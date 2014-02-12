class AddCardToInvestors < ActiveRecord::Migration
  def change
    add_column :investors, :card, :string
  end
end
