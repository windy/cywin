class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.integer :project_id
      t.text :description
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
