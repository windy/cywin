class CreateBankStatements < ActiveRecord::Migration
  def change
    create_table :bank_statements do |t|
      t.integer :investor_id
      t.string :image

      t.timestamps
    end
  end
end
