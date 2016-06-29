class AddUsersToRetailerSalesbeatTargers < ActiveRecord::Migration
  def change
  	add_column :retailers,:user_id,:integer
  	add_column :targets,:user_id,:integer
  	add_column :sales_beats,:user_id,:integer
  	add_foreign_key :retailers,:users
  	add_foreign_key :targets,:users
  	add_foreign_key :sales_beats,:users
  end
  	
end
