class CreateMoneyRequires < ActiveRecord::Migration
  def change
    create_table :money_requires do |t|
      t.integer :money
      t.integer :share
      t.text :description

      t.string :status, default: 'ready'
      t.datetime :deadline
      
      t.integer :project_id
      t.timestamps
    end
  end
end
