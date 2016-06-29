class AddLocationCodeIntoSalesBeats < ActiveRecord::Migration
  def change
  	add_column :sales_beats,:location_code,:string
   end
end
