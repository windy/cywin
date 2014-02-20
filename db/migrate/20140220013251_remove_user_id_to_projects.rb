class RemoveUserIdToProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :user_id, :string
  end
end
