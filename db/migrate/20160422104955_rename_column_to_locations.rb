class RenameColumnToLocations < ActiveRecord::Migration
  def change
  	remove_foreign_key :locations, :retailers
  	rename_column :locations,:retailer_id,:object_id
  end
end
