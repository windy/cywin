class AddIsReadToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :is_read, :boolean
  end
end
