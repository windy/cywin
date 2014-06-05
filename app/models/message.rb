class Message < ActiveRecord::Base
  paginates_per 10
  my_const_set('ACTIONS',
  [
    :LEADER_INVITE,
    :LEADER_CONFIRM,
    :APPLY_INVESTOR_SUCCESS,
    :APPLY_INVESTOR_FAIL,
  ])
  belongs_to :user
  belongs_to :project
  belongs_to :target, :polymorphic => true

  scope :default_order, -> { order('created_at DESC') }
  scope :untreat, -> { where(status: nil) }

  def is_read?
    !! is_read
  end

  def is_treat?
    must_action && status
  end

  def done?
    status == 'done' or status == 'accepted'
  end

  def rejected?
    status == 'rejected'
  end
end
