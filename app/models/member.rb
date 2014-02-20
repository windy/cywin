class Member < ActiveRecord::Base
  ROLES = [ "创始人", "团队成员", "合作者" ]
  PRIVS = [ "owner", "editor", "viewer" ]
  validates :role, presence: true, inclusion: ROLES
  validates :priv, presence: true, inclusion: PRIVS
end
