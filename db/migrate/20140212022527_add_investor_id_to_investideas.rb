class AddInvestorIdToInvestideas < ActiveRecord::Migration
  def change
    add_column :investideas, :investor_id, :integer
  end
end
