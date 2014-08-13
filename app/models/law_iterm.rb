class LawIterm < ActiveRecord::Base
  validates :title, :description, presence: true

  belongs_to :project

  has_and_belongs_to_many :money_requires

  def self.project_law_iterms(project_id)
    LawIterm.where("public = 't' OR project_id = ?", project_id)
  end
end
