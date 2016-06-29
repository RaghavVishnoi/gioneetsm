class AddLocationCodeIntoRetailers < ActiveRecord::Migration
  def change
  	add_column :retailers,:location_code,:string
  	add_index :zusers,:location_code
  end
end
