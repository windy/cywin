class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :oneword
      t.text :description
      t.string :stage # 暂时不用
      t.string :industry
      t.string :city

      t.boolean :published, default: false

      t.timestamps
    end
  end
end
