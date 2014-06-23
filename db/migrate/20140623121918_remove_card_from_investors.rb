class RemoveCardFromInvestors < ActiveRecord::Migration
  def change
    remove_column :investors, :card
  end
end
