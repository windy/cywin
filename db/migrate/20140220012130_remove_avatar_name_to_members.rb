class RemoveAvatarNameToMembers < ActiveRecord::Migration
  def change
    remove_column :members, :avatar, :string
    remove_column :members, :name, :string
  end
end
