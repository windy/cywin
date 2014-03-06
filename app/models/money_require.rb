class MoneyRequire < ActiveRecord::Base
  validates :money, presence: true
  validates :share, presence: true

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
