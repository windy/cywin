class AddMoneyAndMoneyRequireIdToInvestments < ActiveRecord::Migration
  def change
    add_column :investments, :money, :string
    add_column :investments, :money_require_id, :integer
  end
end
