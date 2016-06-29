class AddObjectTypeToImages < ActiveRecord::Migration
  def change
    add_column :images, :object_type, :string
  end
end
