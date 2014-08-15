class AddHeadIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :head_id, :integer
  end
end
