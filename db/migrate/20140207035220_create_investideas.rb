class CreateInvestideas < ActiveRecord::Migration
  def change
    create_table :investideas do |t|
      t.string :coin_type
      t.integer :min
      t.integer :max
      t.string :industry
      t.string :idea
      t.string :give

      t.integer :investor_id

      t.timestamps
    end
  end
end
