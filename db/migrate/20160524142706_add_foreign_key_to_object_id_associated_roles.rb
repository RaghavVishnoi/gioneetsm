class AddForeignKeyToObjectIdAssociatedRoles < ActiveRecord::Migration
  def change
  	  	add_foreign_key :associated_roles,:users,column: :object_id
  end
end
