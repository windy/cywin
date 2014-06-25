class User < ActiveRecord::Base

  searchable do
    text :name, :description
  end

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:weibo]

  has_many :authentications

  validates :name, presence: true

  has_one :avatar
  # 投资角色
  has_one :investor
  has_many :investments
  has_and_belongs_to_many :projects, join_table: :members
  has_many :members
  # 关注功能
  has_many :stars
  # 粉丝功能
  has_many :funs
  has_many :messages

  has_many :events

  has_and_belongs_to_many :person_requires

  def add_star(project)
    unless self.stars.where(project_id: project.id).first
      star = Star.new(user: self, project: project)
      self.stars << star
      self.save
    end
  end

  def remove_star(project)
    self.stars.where(project_id: project.id).destroy_all
  end

  def star?(project)
    !! self.stars.where(project_id: project.id).first
  end

  def add_fun(user)
    unless self.funs.where(interested_user_id: user.id).first
      fun = Fun.new(user: self, interested_user_id: user.id)
      self.funs << fun
      self.save
    end
  end

  def remove_fun(user)
    self.funs.where(interested_user_id: user.id).destroy_all
  end

  def fun?(user)
    !! self.funs.where(interested_user_id: user.id).first
  end

  def avatar_url
    if self.avatar.blank?
      self.avatar = Avatar.new
      self.save!
    end
    self.avatar.image_url
  end

  def mark_all_as_read
    self.messages.unread.update_all(is_read: true, read_at: DateTime.now)
  end

end
