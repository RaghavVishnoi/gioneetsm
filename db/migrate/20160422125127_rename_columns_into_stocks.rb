class RenameColumnsIntoStocks < ActiveRecord::Migration
  def change
  	rename_column :stocks,:mod_id,:object_id
  	rename_column :stocks,:mod_type,:object_type
  end
end
