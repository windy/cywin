class AddUniqnessIndexToMembers < ActiveRecord::Migration
  def change
    add_index(:members, [:user_id, :project_id], :unique => true)
  end
end
