class AddWhere3ToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :where3, :string
  end
end
