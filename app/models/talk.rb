class Talk < ActiveRecord::Base

  belongs_to :user
  belongs_to :target, polymorphic: true

  scope :most_a_week, ->(t=6) { group(:target_id).order("COUNT(*) DESC").having("'created_at' > ?", 1.week.ago).limit(t).count }
  
  scope :most_a_month, ->(t=6) { group(:target_id).order("COUNT(*) DESC").having("'created_at' > ?", 1.month.ago).limit(t).count }

end
