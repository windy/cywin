class AddClosedAtSuccessToMoneyRequires < ActiveRecord::Migration
  def change
    add_column :money_requires, :closed_at, :datetime
    add_column :money_requires, :success, :boolean
  end
end
