class AddStatusToPersonRequires < ActiveRecord::Migration
  def change
    add_column :person_requires, :status, :string, default: :opened
  end
end
