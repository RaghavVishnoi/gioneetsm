class RemoveNdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :nd
  end
end
