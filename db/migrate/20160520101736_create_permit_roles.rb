class CreatePermitRoles < ActiveRecord::Migration
  def change
    create_table :permit_roles do |t|
      t.integer :parent_role
      t.integer :child_role

      t.timestamps null: false
    end
    add_foreign_key :permit_roles,:roles,column: :parent_role
    add_foreign_key :permit_roles,:roles,column: :child_role
  end
end
