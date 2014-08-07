class RemoveColoumnsNameAndDescriptionFromInvestors < ActiveRecord::Migration
  def change
    remove_column :investors, :name, :description
  end
end
