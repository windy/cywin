class RenameTypeInvestorTypeToInvestors < ActiveRecord::Migration
  def change
    remove_column :investors, :type
    add_column :investors, :investor_type, :string

    remove_column :investideas, :type
    add_column :investideas, :coin_type, :string
  end
end
