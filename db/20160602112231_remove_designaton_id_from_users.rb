class RemoveDesignatonIdFromUsers < ActiveRecord::Migration
  def change
  	remove_foreign_key :users,:designations
  	remove_column :users,:designation_id
  end
end
