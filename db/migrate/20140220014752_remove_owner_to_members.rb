class RemoveOwnerToMembers < ActiveRecord::Migration
  def change
    remove_column :members, :owner, :string
  end
end
