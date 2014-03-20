class AddLeaderIdToMoneyRequires < ActiveRecord::Migration
  def change
    add_column :money_requires, :leader_id, :integer
  end
end
