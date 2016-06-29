class CreateDesignations < ActiveRecord::Migration
  def change
    create_table :designations do |t|
    	t.integer :role_id
    	t.string :designation_name
      t.timestamps null: false
    end
    add_foreign_key :designations,:roles
  end
end
