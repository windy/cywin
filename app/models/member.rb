class Member < ActiveRecord::Base
  has_and_belongs_to_many :projects
  mount_uploader :avatar, AvatarUploader
  validates :avatar, :name, :title, presence: true
end
