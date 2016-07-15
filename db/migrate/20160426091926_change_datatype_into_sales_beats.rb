class ChangeDatatypeIntoSalesBeats < ActiveRecord::Migration
  def change
  	remove_column :sales_beats,:is_sis_maintained
  	add_column :sales_beats,:is_sis_maintained,:integer
  	remove_column :sales_beats,:is_gsb_maintained
  	add_column :sales_beats,:is_gsb_maintained,:integer
  	remove_column :sales_beats,:gcs_present
  	add_column :sales_beats,:gcs_present,:integer
  end
end
