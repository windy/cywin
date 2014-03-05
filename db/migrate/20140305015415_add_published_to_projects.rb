class AddPublishedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :published, :boolean, default: false
  end
end
