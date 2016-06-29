class CreateAssociatedRoles < ActiveRecord::Migration
  def change
    create_table :associated_roles do |t|
      t.integer :object_id
      t.string :object_type
      t.integer :role_id
      t.timestamps
    end
    add_index :associated_roles, [:object_id, :object_type]
  end
end


 