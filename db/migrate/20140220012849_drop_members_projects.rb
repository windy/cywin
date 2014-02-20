class DropMembersProjects < ActiveRecord::Migration
  def change
    drop_table :members_projects
  end
end
