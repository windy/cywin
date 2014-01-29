class AddProjectIdToPersonRequires < ActiveRecord::Migration
  def change
    add_column :person_requires, :project_id, :integer
  end
end
