class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :investor_id
      t.string :image

      t.timestamps
    end
  end
end
