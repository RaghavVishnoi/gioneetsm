class ChangeColumnToRetailers < ActiveRecord::Migration
  def change
  	change_column :retailers,:store_area,:float
  end
end
