class AddIndexToZsales < ActiveRecord::Migration
  def change
  	add_index :zsales,:location_code
  end
end
