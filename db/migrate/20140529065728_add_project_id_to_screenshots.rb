class AddProjectIdToScreenshots < ActiveRecord::Migration
  def change
    add_column :screenshots, :project_id, :integer
  end
end
