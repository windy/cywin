class Project < ActiveRecord::Base
  my_const_set('STAGES', [ 'IDEA', 'DEVELOPING', 'ONLINE', 'GAINED' ])
    
  validates :name, presence: true, uniqueness: true
  validates :oneword, presence: true
  #validates :stage, presence: true, inclusion: STAGES
  validates :description, presence: true

  has_one :logo
  has_one :contact
  has_and_belongs_to_many :users, join_table: :members
  has_many :members, autosave: true
  
  # 创业需求
  has_many :money_requires
  has_many :person_requires

  # 关注人员
  has_many :stars

  has_and_belongs_to_many :categories
  def categories_name 
    self.categories.collect { |c| c.name }.join(',')
  end

  has_and_belongs_to_many :cities
  def cities_name 
    self.cities.collect { |c| c.name }.join(',')
  end

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
    member.priv = option[:priv] || 'viewer'
    member.role = option[:role] || Member::MEMBER
    self.members << member
  end

  def remove_user( user )
    Member.where(user_id: user.id, project_id: self.id).destroy_all
  end

  def members_but(user)
    self.members.where.not(user_id: user.id)
  end

  def members_without_owner
    self.members.where.not(priv: 'owner')
  end

  def complete_degree
    0.8
  end

  def opened_money_require
    self.money_requires.where.not(status: :closed).first
  end

  def history_money_requires
    self.money_requires.where(status: :closed).order(created_at: :desc)
  end
  
  # 所有投资人
  def investor_users
    money_require_ids = self.money_requires.collect { |m| m.id }
    investor_ids = Investment.where(money_require_id: money_require_ids).collect{ |m| m.investor_id }
    user_ids = Investor.where(id: investor_ids).collect{ |m| m.user_id }
    User.where(id: user_ids)
  end

  def publish
    #TODO 检查完成度
    self.published = true
    self.save
  end

  def published?
    self.published
  end

  def star_users
    user_ids = self.stars.collect { |m| m.user_id }
    User.where(id: user_ids)
  end
end
