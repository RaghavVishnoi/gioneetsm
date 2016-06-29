class AddColumnToUsers < ActiveRecord::Migration
  def change
  	 add_column :users, :first_name, :string
  	 add_column :users, :last_name, :string
  	 add_column :users, :mobile_number, :string
  	 add_column :users, :office_number, :string
  	 add_column :users, :landline_number, :string
  	 add_column :users, :state, :string
  	 add_column :users, :designation, :string	
  end
end
