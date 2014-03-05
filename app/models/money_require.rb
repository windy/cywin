class MoneyRequire < ActiveRecord::Base
  validates :money, presence: true
  validates :share, presence: true

  has_many :investments
end
