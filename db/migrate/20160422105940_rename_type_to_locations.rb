class RenameTypeToLocations < ActiveRecord::Migration
  def change
  	rename_column :locations,:type,:object_type
  end
end
