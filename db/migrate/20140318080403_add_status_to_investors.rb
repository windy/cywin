class AddStatusToInvestors < ActiveRecord::Migration
  def change
    add_column :investors, :status, :string
  end
end
