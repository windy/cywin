class AddResumeLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :resume_link, :string
  end
end
