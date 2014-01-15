class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :oneword
      t.text :description
      t.string :stage
      t.string :where1
      t.string :where2

      t.timestamps
    end
  end
end
