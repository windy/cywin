class MoneyRequire < ActiveRecord::Base
  NP_MIN = 1
  NP_MAX = 30
  validates :money, presence: true, numericality: { greater_than_or_equal_to: 1000, only_integer: true }
  validates :share, presence: true, numericality: { greater_than: 0, less_than: 100, only_integer: true }

  validates :deadline, presence: true, numericality: { greater_than_or_equal_to: 30, only_integer: true }

  validates :maxnp, numericality: { greater_than_or_equal_to: MoneyRequire::NP_MIN, less_than_or_equal_to: MoneyRequire::NP_MAX, only_integer: true }

  belongs_to :project
  validates :project_id, presence: true

  has_many :investments

  has_and_belongs_to_many :law_iterms

  belongs_to :leader, class_name: User

  # 不能同时有两个融资需求打开
  validate do |m|
    if m.new_record?
      found = MoneyRequire.where(project_id: m.project_id).where.not(status: :closed).first
    else
      found = MoneyRequire.where(project_id: m.project_id).where.not(status: :closed).where.not(id: m.id).first
    end
    if found
      errors.add(:base, "不能在已经存在融资需求时再创建一个")
    end
  end

  # confirmed:
  # ready -> leader_needed / preheated -> leader_need_confirmed -> opened -> closed
  # rejected: 
  # ready -> leader_needed / preheated -> leader_need_confirmed
  #                     ^______________________|
  #
  state_machine :status, initial: :ready do
    event :preheat do
      transition ready: :leader_needed
    end

    after_transition on: :preheat do |money_require, transition|
      Event.create(
        user: money_require.project.owner,
        project_id: money_require.project_id,
        action: Event::MONEY_REQUIRE_CREATE,
        target: money_require,
      )
    end

    event :add_leader do
      transition leader_needed: :leader_need_confirmed
    end

    after_transition on: :add_leader do |money_require, transition|
      money_require.add_leader_notify
      Event.create(
        user: money_require.project.owner,
        project_id: money_require.project_id,
        action: Event::MONEY_REQUIRE_LEADER,
        target: money_require,
      )
    end

    event :leader_confirm do
      transition leader_need_confirmed: :opened
    end

    after_transition on: :leader_confirm do |money_require, transition|
      money_require.opened_at = DateTime.now
      money_require.save!
      money_require.add_leader_confirm_notify

      # 将消息标记为已处理
      Message.where(
        action: Message::LEADER_INVITE,
        target_type: :MoneyRequire,
        target_id: money_require.id,
      ).first.done

      Event.create(
        user: money_require.project.owner,
        project_id: money_require.project_id,
        action: Event::MONEY_REQUIRE_OPENED,
        target: money_require,
      )
    end

    event :leader_reject do
      transition leader_need_confirmed: :leader_needed
    end

    after_transition on: :leader_reject do |money_require, transition|
      money_require.leader_id = nil
      money_require.add_leader_reject_notify
      # 将消息标记为已处理
      Message.where(
        action: Message::LEADER_INVITE,
        target_type: :MoneyRequire,
        target_id: money_require.id,
      ).last.reject
    end

    state :leader_need_confirmed, :opened do
      validates_presence_of :leader_id
    end

    event :close do
      transition opened: :closed
      transition leader_needed: :closed
    end

    after_transition on: :close do |money_require, transition|
      money_require.closed_at = DateTime.now
      if money_require.progress < 1
        money_require.success = false
      else
        money_require.success = true
      end
      money_require.save!
    end
  end

  # 虚拟属性
  def ended_at
    if self.status == 'closed'
      self.closed_at
    end
  end

  # 剩余天数
  def left
    if self.opened?
      (( self.deadline.days - ( Time.now - self.opened_at ) ) / 60 / 60 / 24 ).to_i
    end
  end

  def cost
    if self.closed?
      ( (self.closed_at - self.opened_at)/ 60 / 60 /24 ).to_i
    end
  end

  # 每笔投资最低额度
  def min_money
    (self.money.to_f / self.maxnp).ceil
  end

  # 查询融资进度
  # 返回百分比,如 10% -> 0.1
  def progress
    (self.investments.inject(0) { |s,m| s + m.money }).to_f / self.money
  rescue
    0
  end
  
  def syndicate_money
    (self.investments.inject(0) { |s,m| s + m.money })
  end

  def has_invested?(user)
    !! ( user && user.investor && self.investments.where(user_id: user.id).first )
  end

  def already_money(user)
    self.investments.where(user_id: user.id).first.try(:money)
  end

  def already_investment_id(user)
    self.investments.where(user_id: user.id).first.try(:id)
  end

  def add_leader_and_wait_confirm(leader_id)
    self.leader_id = leader_id
    add_leader
  end

  def owner
    self.project.owner
  end

  def leader_user
    self.leader
  end

  # 仅仅用来测试
  def quickly_turn_on!(leader_id)
    self.leader_id = leader_id
    self.opened_at = Time.now
    self.status = 'opened'
    self.save!
  end
  
  def leader_confirm_and_invest(investment, leader_word: nil)
    money_require = self
    ActiveRecord::Base.transaction do
      money_require.leader_word = leader_word
      money_require.save!
      money_require.leader_confirm!
      investment.save!
    end
    true
  rescue
    false
  end

  def add_leader_notify
    Message.create!(
      user_id: self.leader.id,
      project_id: self.project.id,
      action: Message::LEADER_INVITE,
      must_action: true,
      target_type: :MoneyRequire,
      target_id: self.id,
    )
  end

  def add_leader_confirm_notify
    Message.create!(
      user_id: self.owner.id,
      project_id: self.project.id,
      action: Message::LEADER_CONFIRM,
      must_action: false,
      target_type: :MoneyRequire,
      target_id: self.id,
    )
  end

  def add_leader_reject_notify
    Message.create!(
      user_id: self.owner.id,
      project_id: self.project.id,
      action: Message::LEADER_REJECT,
      must_action: false,
      target_type: :MoneyRequire,
      target_id: self.id,
    )
  end

  def can_edit?
    self.status != 'opened' and self.status != 'closed'
  end

end
