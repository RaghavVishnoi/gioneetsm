class UpdateZusers < ActiveRecord::Migration
  def change
  	change_column :zusers,:last_updated_on,:datetime
  	change_column :zusers,:status,:integer
  end
end
