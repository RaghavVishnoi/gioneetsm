class ChangeDatattypeIntoSalesBeatsAndStocks < ActiveRecord::Migration
  def change
  	remove_column :sales_beats,:stock_count
  	add_column :sales_beats,:stock_count,:integer
  	remove_column :stocks,:count
  	add_column :stocks,:count,:string
  end
end
