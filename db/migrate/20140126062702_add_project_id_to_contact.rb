class AddProjectIdToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :project_id, :integer
  end
end
