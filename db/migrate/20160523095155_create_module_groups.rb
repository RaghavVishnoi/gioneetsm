class CreateModuleGroups < ActiveRecord::Migration
  def change
    create_table :module_groups do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
