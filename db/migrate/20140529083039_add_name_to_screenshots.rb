class AddNameToScreenshots < ActiveRecord::Migration
  def change
    add_column :screenshots, :name, :string
  end
end
