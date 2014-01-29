class CreateProjectsMembers < ActiveRecord::Migration
  def change
    create_table :projects_members do |t|
      t.belongs_to :project
      t.belongs_to :member
      t.timestamps
    end
  end
end
