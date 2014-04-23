class CreatePersonRequires < ActiveRecord::Migration
  def change
    create_table :person_requires do |t|
      t.string :title
      t.integer :pay
      t.integer :stock
      t.integer :option
      t.text :description
      t.integer :project_id
      t.boolean :remote, default: false
      t.boolean :part, default: false

      t.timestamps
    end
  end
end
