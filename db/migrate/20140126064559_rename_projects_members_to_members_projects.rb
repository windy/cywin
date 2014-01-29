class RenameProjectsMembersToMembersProjects < ActiveRecord::Migration
  def change
    rename_table :projects_members, :members_projects
  end
end
