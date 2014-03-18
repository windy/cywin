class AddStatusToInvestors < ActiveRecord::Migration
  def change
    add_column :investors, :status, :string, default: :drafted
  end
end
