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

  # 不能同时有两个融资需求打开
  #FIXME 效率可能存在问题
  validate do |m|
    if m.new_record?
      found = MoneyRequire.where(project_id: m.project_id).where(status: :open).first
    else
      found = MoneyRequire.where(project_id: m.project_id).where(status: :open).where.not(id: m.id).first
    end
    if found
      errors.add(:base, "不能在已经存在融资需求时再创建一个")
    end
  end

  state_machine :status, initial: :ready do
    event :start do
      transition ready: :open
    end

    event :close do
      transition open: :close
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
end
