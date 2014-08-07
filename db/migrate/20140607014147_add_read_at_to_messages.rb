class AddReadAtToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read_at, :datetime
  end
end
