class Member < ActiveRecord::Base
  has_and_belongs_to_many :projects
  mount_uploader :avatar, AvatarUploader
end
