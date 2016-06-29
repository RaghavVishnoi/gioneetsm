class CreateUserParents < ActiveRecord::Migration
  def change
    create_table :user_parents do |t|
    	t.integer :parent_id
    	t.integer :child_id
    end
     add_foreign_key :user_parents,:roles,column: :parent_id
    add_foreign_key :user_parents,:roles,column: :child_id
  end
end
