class AddNdToUsers < ActiveRecord::Migration
  def change
  	  	 add_column :users, :nd, :string
  end
end
