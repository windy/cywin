class AddAvatarToUsers < ActiveRecord::Migration
  def change
    # 如果已经有相关字段, 则返回即可
    add_column :users, :avatar, :string rescue nil
  end
end
