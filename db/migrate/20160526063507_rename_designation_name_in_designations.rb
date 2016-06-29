class RenameDesignationNameInDesignations < ActiveRecord::Migration
  def change
  	rename_column :designations, :designation_name, :name
  end
end
