class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.string :name
      t.string :address
      t.text :description
      t.integer :money

      t.integer :money_require_id
      t.integer :user_id

      t.timestamps
    end
  end
end
