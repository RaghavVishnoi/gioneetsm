class CreateSalesBeats < ActiveRecord::Migration
  def change
    create_table :sales_beats do |t|
    	t.string :mum
    	t.string :rds
    	t.string :date
    	t.string :retailer_code
    	t.integer :stock_count
    	t.boolean :is_sis_maintained
    	t.boolean :is_gsb_maintained
    	t.boolean :gcs_present
      	t.timestamps null: false
    end
  end
end
