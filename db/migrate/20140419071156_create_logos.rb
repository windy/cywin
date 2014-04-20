class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.integer :project_id
      t.string :image

      t.timestamps
    end
  end
end
