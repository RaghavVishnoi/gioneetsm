class ChangeDatattypeIntoSalesBeatsAndStocks < ActiveRecord::Migration
  def change
  	change_column :sales_beats,:stock_count,:integer
  	change_column :stocks,:count,:string
  end
end
