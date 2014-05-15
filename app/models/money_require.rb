class MoneyRequire < ActiveRecord::Base
  validates :money, presence: true, numericality: { greater_than_or_equal_to: 1000, only_integer: true }
  validates :share, presence: true, numericality: { greater_than: 0, less_than: 100, only_integer: true }

  validates :deadline, presence: true, numericality: { greater_than_or_equal_to: 30, only_integer: true }

  belongs_to :project
  validates :project_id, presence: true

  has_many :investments

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

  # ready -> leader_needed -> leader_need_confirmed -> opened -> closed
  state_machine :status, initial: :ready do
    event :preheat do
      transition ready: :leader_needed
    end

    event :add_leader do
      transition leader_needed: :leader_need_confirmed
    end

    after_transition on: :add_leader do |money_require, transition|
      money_require.add_leader_notify
    end

    event :leader_confirm do
      transition leader_need_confirmed: :opened
    end

    after_transition on: :leader_confirm do |money_require, transition|
      money_require.opened_at = DateTime.now
      money_require.save!
      money_require.add_leader_confirm_notify
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
      self.opened_at + self.deadline.days
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
    user && user.investor && self.investments.where(investor_id: user.investor.id).first
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

end
