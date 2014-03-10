class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :target_type
      t.integer :target_id
      t.string :title
      t.text :data
      t.integer :project_id
      t.string :action
      t.integer :user_id

      t.timestamps
    end
  end
end
