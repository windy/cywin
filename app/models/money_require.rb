class MoneyRequire < ActiveRecord::Base
  validates :money, presence: true
  validates :share, presence: true
end
