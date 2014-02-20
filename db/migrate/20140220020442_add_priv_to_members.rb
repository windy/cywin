class AddPrivToMembers < ActiveRecord::Migration
  def change
    add_column :members, :priv, :string
  end
end
