class AddCityStateToRetailers < ActiveRecord::Migration
  def change
  	add_column :retailers,:state,:string
  	add_column :retailers,:city,:string
  end
end
