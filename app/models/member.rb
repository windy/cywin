class Member < ActiveRecord::Base
  ROLES = [ "创始人", "团队成员", "合作者" ]
  PRIVS = [ "owner", "editor", "viewer" ]
  validates :role, presence: true, inclusion: ROLES
  validates :priv, presence: true, inclusion: PRIVS
  belongs_to :user
  belongs_to :project

  #FIXME 错误信息提示不全, 考虑使用 gem: custom_error_message
  validates :user_id, uniqueness: { scope: :project_id, message: '用户已经存在于项目'}
end
