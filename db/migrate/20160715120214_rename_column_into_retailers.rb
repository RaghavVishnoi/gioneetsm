class RenameColumnIntoRetailers < ActiveRecord::Migration
  def change
  	rename_column :retailers,:tmpCode,:tmpcode
  	rename_column :retailers,:tmpCount,:tmpcount
  end
end
