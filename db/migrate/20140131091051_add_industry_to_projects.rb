class AddIndustryToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :industry, :string
  end
end
