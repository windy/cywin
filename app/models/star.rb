class Star < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  scope :most_a_week, ->(t=6) { group(:project_id).order("COUNT(*) DESC").having("'created_at' > ?", 1.week.ago).limit(t).count }

end
