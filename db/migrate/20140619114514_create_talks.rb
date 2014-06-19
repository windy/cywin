class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :target_type
      t.integer :target_id
      t.integer :user_id

      t.timestamps
    end
  end
end
