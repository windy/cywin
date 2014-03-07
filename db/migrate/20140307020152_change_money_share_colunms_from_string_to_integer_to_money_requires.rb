class ChangeMoneyShareColunmsFromStringToIntegerToMoneyRequires < ActiveRecord::Migration
  def change
    change_column :money_requires, :money, :integer
    change_column :money_requires, :share, :integer
  end
end
