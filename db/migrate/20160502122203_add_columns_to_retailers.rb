class AddColumnsToRetailers < ActiveRecord::Migration
  def change
  	add_column :retailers,:mum,:string
  	add_column :retailers,:retailer_phone,:string
  end
end
