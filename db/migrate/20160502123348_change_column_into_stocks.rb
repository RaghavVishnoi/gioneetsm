class ChangeColumnIntoStocks < ActiveRecord::Migration
  def change
  	remove_column :stocks,:count
  	add_column :stocks,:count,:integer
  end
end
