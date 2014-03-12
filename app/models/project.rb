class Project < ActiveRecord::Base
  #STAGES = [ '概念中', '开发中', '已上线', '已盈利']
  STAGES = []
  [
    :IDEA,
    :DEVELOPING,
    :ONLINE,
    :GAINED
  ].each do |e|
    real_name = e.to_s.underscore
    STAGES << real_name
    const_set(e, real_name)
  end
    
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

  scope :published, -> { where(published: true) }

  def add_owner( owner )
    add_user(owner, role: Member::FOUNDER, priv: 'owner')
  end
  
  # user 
  def owner
    self.users.where('members.priv' => 'owner').first
  end

  def member( user )
    self.members.where(user_id: user.id).first
  end

  def add_user( user, option={} )
    member = Member.new
    member.user = user
    #TODO 处理权限的控制
    member.priv = option[:priv] || 'viewer'
    member.role = option[:role]
    self.members << member
  end

  def members_but(user)
    self.members.where.not(user_id: user.id)
  end

  def complete_degree
    0.8
  end

  def opened_money_require
    self.money_requires.where(status: :open).first
  end

  def history_money_requires
    self.money_requires.where.not(status: :open).order(created_at: :desc)
  end

  def publish
    #TODO 检查完成度
    self.published = true
    self.save
  end

  def published?
    self.published
  end
end
