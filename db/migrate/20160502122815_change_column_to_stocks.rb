class ChangeColumnToStocks < ActiveRecord::Migration
  def change
  	change_column :stocks,:count,:string
  end
end
