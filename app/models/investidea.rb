class Investidea < ActiveRecord::Base
  COIN_TYPE = ["人民币", "外币", "人民币+外币"]
  validates :coin_type, :min, :max, :industry, :give, :idea, presence: true
end
