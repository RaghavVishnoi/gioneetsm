class CreateZusers < ActiveRecord::Migration
  def change
    create_table :zusers do |t|
    	t.string :location_code
    	t.string :location_type
    	t.string :person_name
    	t.string :parent_location_code
    	t.string :email
    	t.string :mobile_number
    	t.string :employee_code
    	t.string :last_updated_on
    	t.string :status
    	t.timestamps
    end
  end
end
