class ChangeDesignationsToIntegerInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :designation, :integer,:default=> 0
  	rename_column :users, :designation, :designation_id
  	add_foreign_key :users,:designations
  end
end
