class UpdateZusers < ActiveRecord::Migration
  def change
  	remove_column :zusers,:last_updated_on
  	add_column :zusers,:last_updated_on,:datetime
  	remove_column :zusers,:status
  	add_column :zusers,:status,:integer
  end
end
