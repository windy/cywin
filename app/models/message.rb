class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, :polymorphic => true

  scope :default_order,    order('created_at DESC')
end
