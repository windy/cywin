class AddLeaderWordToMoneyRequires < ActiveRecord::Migration
  def change
    add_column :money_requires, :leader_word, :text
  end
end
