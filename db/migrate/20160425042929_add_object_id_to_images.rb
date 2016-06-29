class AddObjectIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :object_id, :integer
  end
end
