class RenameColumnToFocusModels < ActiveRecord::Migration
  def change
  	rename_column :focus_models,:model_name,:target_model_name
  end
end
