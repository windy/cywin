class AddOpenedAtToMoneyRequires < ActiveRecord::Migration
  def change
    add_column :money_requires, :opened_at, :datetime
  end
end
