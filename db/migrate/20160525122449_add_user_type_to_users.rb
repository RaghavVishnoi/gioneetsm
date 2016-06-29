class AddUserTypeToUsers < ActiveRecord::Migration
  def change
  	add_column :user_states,:user_type,:string
  end
end
