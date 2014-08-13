class CreateLawIterms < ActiveRecord::Migration
  def change
    create_table :law_iterms do |t|
      t.string :title
      t.text :description
      t.integer :project_id
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
