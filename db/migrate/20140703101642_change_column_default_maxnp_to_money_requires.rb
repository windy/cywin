class ChangeColumnDefaultMaxnpToMoneyRequires < ActiveRecord::Migration
  def change
    change_column_default :money_requires, :maxnp, nil
  end
end
