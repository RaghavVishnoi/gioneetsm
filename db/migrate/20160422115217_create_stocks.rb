class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
    	t.string :mod_name
    	t.integer :count
    	t.string :mod_type
    	t.integer :mod_id
    	t.timestamps
    end
  end
end
