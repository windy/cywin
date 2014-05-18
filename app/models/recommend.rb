class Recommend < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :project_id
  validates_uniqueness_of :project_id
  validate do |r|
    errors.add(:project_id, "ID 不存在") unless Project.where(id: r.project_id).first
  end

  default_scope -> { where(deleted: false) }
end
