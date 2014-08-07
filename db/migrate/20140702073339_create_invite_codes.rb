class CreateInviteCodes < ActiveRecord::Migration
  def change
    create_table :invite_codes do |t|
      t.integer :code
      t.boolean :used, default: false

      t.timestamps
    end
  end
end
