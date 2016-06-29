class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :role_id
      t.integer :module_group_id
      t.timestamps null: false
    end
    add_foreign_key :permissions,:roles
    add_foreign_key :permissions,:module_groups
  end
end
