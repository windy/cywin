class CreateFuns < ActiveRecord::Migration
  def change
    create_table :funs do |t|
      t.integer :user_id
      t.integer :interested_user_id
    end
  end
end
