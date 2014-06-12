class CreateTablePersonRequiresUsers < ActiveRecord::Migration
  def change
    create_table :person_requires_users do |t|
      t.belongs_to :person_require
      t.belongs_to :user
      t.text :note

      t.timestamps
    end
  end
end
