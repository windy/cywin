class CreateInvestors < ActiveRecord::Migration
  def change
    create_table :investors do |t|
      t.string   :name
      t.string   :phone
      t.string   :company
      t.string   :title
      t.text     :description
      t.string   :investor_type
      t.string   :card

      t.string :status, default: :drafted
      t.integer :user_id

      t.timestamps
    end
  end
end
