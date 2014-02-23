class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :address
      t.string :phone
      t.string :qq
      t.string :weixin
      t.string :weibo
      t.integer :project_id

      t.timestamps
    end
  end
end
