class RenameDescriptionTextToMembers < ActiveRecord::Migration
  def change
    change_column :members, :description, :text
  end
end
