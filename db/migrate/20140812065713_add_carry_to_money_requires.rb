class AddCarryToMoneyRequires < ActiveRecord::Migration
  def change
    add_column :money_requires, :carry, :integer
  end
end
