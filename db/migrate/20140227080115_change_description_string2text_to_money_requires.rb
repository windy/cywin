class ChangeDescriptionString2textToMoneyRequires < ActiveRecord::Migration
  def change
    change_column :money_requires, :description, :text
  end
end
