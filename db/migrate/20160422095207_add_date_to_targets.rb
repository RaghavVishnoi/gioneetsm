class AddDateToTargets < ActiveRecord::Migration
  def change
  	add_column :targets,:date,:string
  end
end
