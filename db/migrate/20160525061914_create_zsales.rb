class CreateZsales < ActiveRecord::Migration
  def change
    create_table :zsales do |t|
    	t.string :retailer_name
    	t.string :retailer_code
    	t.string :sales_channel
    	t.string :contact_person
    	t.string :state
    	t.string :city
    	t.string :pincode
    	t.string :tin_number
    	t.string :mobile_number
    	t.string :status,:default=> 'Active'
    	t.string :is_rsp_on_counter
    	t.string :counter_size
    	t.string :nd
    	t.string :lfr_chain
    	t.string :address
    	t.timestamps
    end
  end
end
