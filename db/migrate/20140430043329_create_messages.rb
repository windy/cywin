class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :action
      t.integer :project_id
      t.boolean :must_action
      t.string :status
      t.string :target_type
      t.integer :target_id

      t.timestamps
    end
  end
end
