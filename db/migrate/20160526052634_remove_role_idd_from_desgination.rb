class RemoveRoleIddFromDesgination < ActiveRecord::Migration
  def change
  	remove_foreign_key :designations, :roles
  	remove_column :designations, :role_id
  end
end
