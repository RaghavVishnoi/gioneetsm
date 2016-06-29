class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.float :lat
    	t.float :lng
    	t.text  :location
    	t.integer :retailer_id
    	t.timestamps 
    end
    add_foreign_key :locations,:retailers
  end
end
