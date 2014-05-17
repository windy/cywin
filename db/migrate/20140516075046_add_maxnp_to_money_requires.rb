class AddMaxnpToMoneyRequires < ActiveRecord::Migration
  def change
    add_column :money_requires, :maxnp, :integer, default: 50
  end
end
