class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:weibo]

  has_many :authentications

  acts_as_messageable

  validates :name, presence: true

  mount_uploader :avatar, AvatarUploader
  # 投资角色
  has_one :investor
  has_and_belongs_to_many :projects, join_table: :members
  # 关注功能
  has_many :stars
  # 粉丝功能
  has_many :funs

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

end
