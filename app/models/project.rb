class Project < ActiveRecord::Base
  STAGES = [ '概念中', '开发中', '已上线', '已盈利']
  validates :name, presence: true, uniqueness: true, length: { minimum: 1 }
  validates :oneword, presence: true, length: { minimum: 4 }
  validates :stage, presence: true, inclusion: STAGES
  validates :where1, :where2, :where3, presence: true, format: /\d/, length: 6..6

  validates :logo, presence: true
  validates :user_id, presence: true

  mount_uploader :logo, LogoUploader

  has_one :contact
  has_and_belongs_to_many :members, autosave: true
  accepts_nested_attributes_for :contact
  validates :contact, presence: true
  before_create { build_contact }
  
  # 创业需求
  has_one :money_require
  has_many :person_requires

  def add_owner( owner )
    #TODO 检查只能有一个 owner
    owner.owner = true
    self.members << owner
  end
  
  def owner
    self.members.where(owner: true).first
  end
end
