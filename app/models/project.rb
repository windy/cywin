class Project < ActiveRecord::Base
  validates :name, presence: true, :uniqueness => true, :length => { :minimum => 4 }
  validates :oneword, presence: true, :length => { :minimum => 4 }
  validates :stage, presence: true
  validates :where1, presence: true
  validates :where2, presence: true

  validates :logo, presence: true

  mount_uploader :logo, LogoUploader

  has_one :contact
  has_and_belongs_to_many :members
  accepts_nested_attributes_for :contact
  
  # 创业需求
  has_one :money_require
  has_many :person_requires

  def add_owner( owner )
    #TODO 检查只能有一个 owner
    owner.owner = true
    self.members << owner
  end
end
