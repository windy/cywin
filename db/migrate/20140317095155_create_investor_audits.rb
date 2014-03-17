class CreateInvestorAudits < ActiveRecord::Migration
  def change
    create_table :investor_audits do |t|
      t.integer :investor_id
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end
