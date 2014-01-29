class AddProjectIdToMoneyRequire < ActiveRecord::Migration
  def change
    add_column :money_requires, :project_id, :integer
  end
end
