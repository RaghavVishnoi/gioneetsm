class ChangeDesignationsToIntegerInUsers < ActiveRecord::Migration
  def change
  	remove_column :users,:designation
  	add_column :users, :designation, :integer,:default=> 0
  	rename_column :users, :designation, :designation_id
  	add_foreign_key :users,:designations
  end
end
