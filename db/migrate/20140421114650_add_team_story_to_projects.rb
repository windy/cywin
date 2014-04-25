class AddTeamStoryToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :team_story, :text
  end
end
