class CreateCompetitionDetails < ActiveRecord::Migration
  def change
    create_table :competition_details do |t|
    	t.string :brand_name
    	t.integer :sale
    	t.integer :promoters
    	t.boolean :is_sis
    	t.boolean :is_gsb
    	t.integer :retailer_id
    	t.timestamps
    end
    add_foreign_key :competition_details,:retailers
  end
end
