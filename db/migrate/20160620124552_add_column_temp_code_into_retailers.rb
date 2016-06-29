class AddColumnTempCodeIntoRetailers < ActiveRecord::Migration
  def change
  	add_column :retailers,:tmpCode,:string
  	add_column :retailers,:tmpCount,:integer
  end
end
