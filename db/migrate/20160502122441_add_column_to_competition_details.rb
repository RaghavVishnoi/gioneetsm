class AddColumnToCompetitionDetails < ActiveRecord::Migration
  def change
  	add_column :competition_details,:volume,:integer
  end
end
