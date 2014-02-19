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
  has_many :projects
end
