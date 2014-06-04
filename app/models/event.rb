class Event < ActiveRecord::Base
  # table columns
  # t.string   "target_type"
  # t.integer  "target_id"
  # t.string   "title"
  # t.text     "data"
  # t.integer  "project_id"
  # t.integer  "action"
  # t.integer  "user_id"

  my_const_set( 'ACTIONS', 
  # actions
  [
  :PROJECT_CREATE,
  :PROJECT_UPDATE,
  :PROJECT_JOIN,
  # 投资
  :PROJECT_INVEST,
  # 约谈
  :PROJECT_TALK,

  # 更新个人资料
  :USER_UPDATE,
  # 被人关注,
  :USER_FUN,
  :PROJECT_STAR,
  # 申请投资人
  :APPLY_INVESTOR,
  :APPLY_INVESTOR_FAIL,
  :APPLY_INVESTOR_SUCCESS ,
  # 申请认证投资人
  :APPLY_LEADER,
  :APPLY_LEADER_FAIL,
  :APPLY_LEADER_SUCCESS ,

  # works
  # 申请工作
  :APPLY_WORK,
  # 申请成功
  :APPLY_WORK_SUCCESS,
  # 工作需求创建
  :PERSON_REQUIRE_CREATE,
  # 工作需求已关闭
  :PERSON_REQUIRE_CLOSE,
  # 对工作感兴趣
  :INTEREST_WORK,
  ])
  validates :action, presence: true, inclusion: ACTIONS
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :target, polymorphic: true
end
