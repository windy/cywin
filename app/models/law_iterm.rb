class LawIterm < ActiveRecord::Base
  validates :title, :description, presence: true

  belongs_to :project

  def self.project_law_iterms(project_id)
    LawIterm.where("public = 't' OR project_id = ?", project_id)
  end
end
