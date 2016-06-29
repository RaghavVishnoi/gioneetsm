class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.string :retailer_name
      t.string :retailer_code
      t.text   :address
      t.string :landmark
      t.integer :store_area
      t.integer :store_monthly_sales_volume
      t.integer :store_monthly_sales_value 	
      t.timestamps null: false
    end
  end
end
