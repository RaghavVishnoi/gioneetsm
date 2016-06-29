class AddForeignKeyToUserStates < ActiveRecord::Migration
  def change
  	add_foreign_key :user_states,:users
  	add_foreign_key :user_states,:states
  end
end
