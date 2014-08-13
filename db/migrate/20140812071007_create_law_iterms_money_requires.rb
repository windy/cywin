class CreateLawItermsMoneyRequires < ActiveRecord::Migration
  def change
    create_table :law_iterms_money_requires do |t|
      t.integer :law_iterm_id
      t.integer :money_require_id
    end
  end
end
