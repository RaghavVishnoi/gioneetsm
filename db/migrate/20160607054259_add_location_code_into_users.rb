class AddLocationCodeIntoUsers < ActiveRecord::Migration
  def change
  	add_column :users,:location_code,:string
  end
end
