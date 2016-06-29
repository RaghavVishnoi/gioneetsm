class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :lat
    	t.string :lng
    	t.string :image
        t.timestamps null: false
    end
  end
end
