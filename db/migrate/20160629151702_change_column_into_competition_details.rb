class ChangeColumnIntoCompetitionDetails < ActiveRecord::Migration
  def change
  	change_column :competition_details,:sale,:string
  end
end
