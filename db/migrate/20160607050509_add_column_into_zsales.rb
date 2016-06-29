class AddColumnIntoZsales < ActiveRecord::Migration
  def change
  	add_column :zsales,:location_code,:string,index: true
  end
end
