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

  state_machine :status, initial: :ready do
    event :start do
      transition ready: :open
    end

    event :close do
      transition open: :close
    end

    event :restart do
      transition close: :open
    end
  end
end
