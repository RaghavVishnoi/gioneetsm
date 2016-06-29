class AddLastLoginAndLogoutToUsers < ActiveRecord::Migration
  def change
  	add_column :users ,:last_login_time,:datetime
  	add_column :users ,:last_logout_time,:datetime
  end
end
