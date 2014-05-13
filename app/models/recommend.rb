class Recommend < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :project_id
  validates_uniqueness_of :project_id
  validates_associated :project

  default_scope -> { where(deleted: false) }
end
