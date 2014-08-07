class Fun < ActiveRecord::Base
  paginates_per 48
  belongs_to :user

  scope :by, ->(user_id) { where(interested_user_id: user_id) }
end
