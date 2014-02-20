class AddUserIdProjectIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :user_id, :integer
    add_column :members, :project_id, :integer
  end
end
