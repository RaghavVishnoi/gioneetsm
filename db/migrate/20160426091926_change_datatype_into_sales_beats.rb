class ChangeDatatypeIntoSalesBeats < ActiveRecord::Migration
  def change
  	change_column :sales_beats,:is_sis_maintained,:integer
  	change_column :sales_beats,:is_gsb_maintained,:integer
  	change_column :sales_beats,:gcs_present,:integer
  end
end
