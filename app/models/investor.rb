class Investor < ActiveRecord::Base
  #INVESTOR_TYPE = [ "个人投资", "机构投资" ]
  INVESTOR_TYPE = []
  [
    :PERSON,
    :ORGANIZATION,
  ].each do |e|
    real_name = e.to_s.underscore
    INVESTOR_TYPE << real_name
    const_set(e, real_name)
  end

  belongs_to :user
  has_many :investment
  has_one :investidea

  validates :user_id, presence: true

  mount_uploader :card, CardUploader
end
