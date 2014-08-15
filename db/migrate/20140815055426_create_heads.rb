class CreateHeads < ActiveRecord::Migration
  def change
    create_table :heads do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
