class ChangeMoneyToInvestment < ActiveRecord::Migration
  def change
    change_column :investments, :money, :integer
  end
end
