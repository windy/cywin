class Member < ActiveRecord::Base
  my_const_set( :ROLES, [:FOUNDER, :MEMBER, :PARTNER ] )

  PRIVS = [ "owner", "editor", "viewer" ]
  validates :role, presence: true, inclusion: ROLES
  validates :priv, presence: true, inclusion: PRIVS
  belongs_to :user
  belongs_to :project

  scope :default_order, -> { where(created_at: :desc) }

  #FIXME 错误信息提示不全, 考虑使用 gem: custom_error_message
  validates :user_id, uniqueness: { scope: :project_id, message: '用户已经存在于项目'}
end
