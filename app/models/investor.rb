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

  # status 标志是否开始审核, 并同时创建审核单
  state_machine :status, initial: :drafted do
    event :submit do
      transition [:drafted, :rejected] => :applied
    end
    
    event :reject do
      transition :applied => :rejected
    end

    event :pass do
      transition :applied => :passed
    end
  end

  belongs_to :user
  has_many :investment
  has_one :investidea

  validates :user_id, presence: true

  # basic info validates

  validates :name, presence: true
  validates :phone, presence: true
  validates :investor_type, presence: true, inclusion: INVESTOR_TYPE
  validates :company, presence: true
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 3 }

  mount_uploader :card, CardUploader
end
