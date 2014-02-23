class CreateMoneyRequires < ActiveRecord::Migration
  def change
    create_table :money_requires do |t|
      t.string :money
      t.string :share
      t.string :description
      
      t.integer :project_id

      t.timestamps
    end
  end
end
