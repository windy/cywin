class ChangeColumnDefaultMaxnp30ToMoneyRequires < ActiveRecord::Migration
  def change
    change_column_default :money_requires, :maxnp, 30
  end
end
