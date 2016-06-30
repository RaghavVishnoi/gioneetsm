class ChangeColumnIntoRetailers < ActiveRecord::Migration
  def change
  	change_column :retailers,:store_monthly_sales_value,:string
  end
end
