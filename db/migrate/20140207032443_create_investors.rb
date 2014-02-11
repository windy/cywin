class CreateInvestors < ActiveRecord::Migration
  def change
    create_table :investors do |t|
      t.integer :user_id
      t.string :type
      t.string :name
      t.string :phone
      t.string :company
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
