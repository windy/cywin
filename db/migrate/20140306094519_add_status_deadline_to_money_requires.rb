class AddStatusDeadlineToMoneyRequires < ActiveRecord::Migration
  def change
    add_column :money_requires, :status, :string, default: :ready
    add_column :money_requires, :deadline, :datetime
  end
end
