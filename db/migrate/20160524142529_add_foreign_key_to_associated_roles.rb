class AddForeignKeyToAssociatedRoles < ActiveRecord::Migration
  def change
  	add_foreign_key :associated_roles,:roles
  end
end
