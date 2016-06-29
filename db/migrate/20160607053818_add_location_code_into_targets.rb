class AddLocationCodeIntoTargets < ActiveRecord::Migration
  def change
  	add_column :targets,:location_code,:string
  end
end
