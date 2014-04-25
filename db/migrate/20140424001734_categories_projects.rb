class CategoriesProjects < ActiveRecord::Migration
  def change
    create_table :categories_projects, id: false do |t|
      t.belongs_to :category
      t.belongs_to :project
    end
  end
end
