class Project < ActiveRecord::Base
  STAGES = [ '概念中', '开发中', '已上线', '已盈利']
  validates :name, presence: true, uniqueness: true, length: { minimum: 1 }
  validates :oneword, presence: true, length: { minimum: 4 }
  validates :stage, presence: true, inclusion: STAGES
  validates :where1, :where2, :where3, presence: true, format: /\d/, length: 6..6

  validates :logo, presence: true

  mount_uploader :logo, LogoUploader

  has_one :contact
  has_and_belongs_to_many :users, join_table: :members
  has_many :members, autosave: true
  accepts_nested_attributes_for :contact
  validates :contact, presence: true
  
  # 创业需求
  has_many :money_requires
  has_many :person_requires

  def add_owner( owner )
    member = Member.new
    member.user_id = owner.id
    member.priv = 'owner'
    member.role = '创始人'
    self.members << member
  end
  
  # user 
  def owner
    self.users.where('members.priv' => 'owner').first
  end

  def member( user )
    self.members.where(user_id: user.id).first
  end
end
