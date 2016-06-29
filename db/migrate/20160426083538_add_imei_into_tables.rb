class AddImeiIntoTables < ActiveRecord::Migration
  def change
  	add_column :retailers,:imei,:string
  	add_column :targets,:imei,:string
  	add_column :sales_beats,:imei,:string
  end
end
