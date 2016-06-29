class ChangeColumnIntoStocks < ActiveRecord::Migration
  def change
  	change_column :stocks,:count,:integer
  end
end
