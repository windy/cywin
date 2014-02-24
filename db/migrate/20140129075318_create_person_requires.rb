class CreatePersonRequires < ActiveRecord::Migration
  def change
    create_table :person_requires do |t|
      t.string :title
      t.string :pay
      t.string :stock
      t.string :option
      t.text :description

      t.integer :project_id

      t.timestamps
    end
  end
end
