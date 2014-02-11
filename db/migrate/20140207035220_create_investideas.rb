class CreateInvestideas < ActiveRecord::Migration
  def change
    create_table :investideas do |t|
      t.string :type
      t.integer :min
      t.integer :max
      t.string :industry
      t.string :idea
      t.string :give

      t.timestamps
    end
  end
end
