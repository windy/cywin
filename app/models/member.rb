class Member < ActiveRecord::Base
  ROLES = []
  [
    :FOUNDER,
    :MEMBER,
    :PARTNER
  ].each do |e|
    real_name = e.to_s.underscore
    ROLES << real_name
    const_set(e, real_name)
  end

  PRIVS = [ "owner", "editor", "viewer" ]
  validates :role, presence: true, inclusion: ROLES
  validates :priv, presence: true, inclusion: PRIVS
  belongs_to :user
  belongs_to :project

  #FIXME 错误信息提示不全, 考虑使用 gem: custom_error_message
  validates :user_id, uniqueness: { scope: :project_id, message: '用户已经存在于项目'}
end
