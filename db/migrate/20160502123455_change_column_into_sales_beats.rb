class ChangeColumnIntoSalesBeats < ActiveRecord::Migration
  def change
  	remove_column :sales_beats,:stock_count
  	add_column :sales_beats,:stock_count,:string
  end
end
