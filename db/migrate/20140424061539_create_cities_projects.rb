class CreateCitiesProjects < ActiveRecord::Migration
  def change
    create_table :cities_projects do |t|
      t.belongs_to :project
      t.belongs_to :city
    end
  end
end
