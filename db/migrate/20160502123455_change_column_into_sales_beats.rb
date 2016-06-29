class ChangeColumnIntoSalesBeats < ActiveRecord::Migration
  def change
  	change_column :sales_beats,:stock_count,:string
  end
end
