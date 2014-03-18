class Investidea < ActiveRecord::Base
  my_const_set('COIN_TYPES', [ 'CNY', 'USD', 'CNY_AND_USD' ])
  validates :industry, :give, :idea, presence: true

  validates :coin_type, presence: true, inclusion: COIN_TYPES
  validates :min, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :max, presence: true, numericality: { greater_than: 0, only_integer: true }

  validate do
    errors.add(:max, '最大投资额必须大于最小投资额') unless max > min
  end

end
