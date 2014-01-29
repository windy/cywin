class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :avatar
      t.string :name
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
