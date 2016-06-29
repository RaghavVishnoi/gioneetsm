class AddProfilePathToUsers < ActiveRecord::Migration
  def change
  	add_column :users,:profile_path,:string
  end
end
