class AddPublishEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :publish_email, :boolean, default: false
  end
end
