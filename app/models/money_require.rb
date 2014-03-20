class MoneyRequire < ActiveRecord::Base
  validates :money, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :share, presence: true, numericality: true, inclusion: 1..100

  validates :deadline, presence: true
  validate do |m|
    errors.add(:base, "时间必须选在未来") unless m.deadline.future?
  end

  belongs_to :project
  validates :project_id, presence: true

  has_many :investments

  belongs_to :leader, class_name: Investor

  # 不能同时有两个融资需求打开
  #FIXME 效率可能存在问题
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

  # ready -> leader_needed -> opened -> closed
  state_machine :status, initial: :ready do
    event :preheat do
      transition ready: :leader_needed
    end

    event :add_leader do
      transition leader_needed: :leader_need_confirmed
    end

    event :leader_confirm do
      transition leader_need_confirmed: :opened
    end

    state :leader_need_confirmed, :opened do
      validates_presence_of :leader_id
    end

    event :close do
      transition opened: :closed
      transition leader_needed: :closed
    end
  end

  # 查询融资进度
  # 返回百分比,如 10% -> 0.1
  def progress
    (self.investments.inject(0) { |s,m| s + m.money }).to_f / self.money
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

  # 仅仅用来测试
  def quickly_turn_on!(leader_id)
    self.leader_id = leader_id
    self.status = 'opened'
    self.save!
  end

end
