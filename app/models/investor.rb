class Investor < ActiveRecord::Base
  INVESTOR_TYPE = [ "个人投资", "机构投资" ]
  belongs_to :user
  has_many :investment
  has_one :investidea

  validates :user_id, presence: true

  mount_uploader :card, CardUploader
end
