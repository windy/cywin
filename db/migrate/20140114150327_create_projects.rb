class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :logo
      t.string :name
      t.string :oneword
      t.text :description
      t.string :stage
      t.string :where1
      t.string :where2
      t.string :where3
      t.string :industry

      t.boolean :published, default: false

      t.timestamps
    end
  end
end
