class CreateFocusModels < ActiveRecord::Migration
  def change
    create_table :focus_models do |t|
    	t.string :model_name
    	t.integer :sale
    	t.integer :target_id
    	t.timestamps
    end
    add_foreign_key :focus_models,:targets
  end
end
