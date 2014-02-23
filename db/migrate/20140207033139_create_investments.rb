class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.string :name
      t.string :address
      t.text :description

      t.integer :investor_id

      t.timestamps
    end
  end
end
