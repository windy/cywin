class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :title
      t.text :description
      
      t.string :priv
      t.string :role
      
      t.integer :user_id
      t.integer :project_id


      t.timestamps
    end
  end
end
