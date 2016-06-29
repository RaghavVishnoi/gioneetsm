class Zsale < ActiveRecord::Base

 	belongs_to :zuser,:class => 'Zuser',foreign_key: 'location_code', primary_key: 'location_code'

	validates :retailer_name,presence: true
    validates :retailer_code,presence: true
    validates :sales_channel,presence: true
 
    validate  :contact_person
    validates :state,presence: true
    validates :city,presence: true
    validate  :pincode
    validate  :tin_number
    validate  :mobile_number
    validates :status,presence: true 
    validate :is_rsp_on_counter
    validate :counter_size
    validate :nd
    validate :lfr_chain
    validate :address

	def self.update(url,start_date,end_date)
		@result = Response.zsales(url,start_date,end_date)['object']	
 		@result.each do |result|
			zsale = self.find_by(retailer_code: result['retailer_code'])
			if zsale != nil
				zsale.update!(retailer_code: result['retailer_code'],
					retailer_name: result['retailer_name'],
					sales_channel: result['sales_channel'],
					contact_person: result['contact_person'],
					state: result['state'],
					city: result['city'],
					pincode: result['pincode'],
					tin_number: result['tin_number'],
					mobile_number: result['mobile_number'],
					status: result['status'],
					is_rsp_on_counter: result['is_rsp_on_counter'],
					counter_size: result['counter_size'],
					nd: result['nd'],
					lfr_chain: result['lfr_chain'],
					location_code: result['location_code'],
					address: result['address'])
			else
				self.create!(retailer_code: result['retailer_code'],
					retailer_name: result['retailer_name'],
					sales_channel: result['sales_channel'],
					contact_person: result['contact_person'],
					state: result['state'],
					city: result['city'],
					pincode: result['pincode'],
					tin_number: result['tin_number'],
					mobile_number: result['mobile_number'],
					status: result['status'],
					is_rsp_on_counter: result['is_rsp_on_counter'],
					counter_size: result['counter_size'],
					nd: result['nd'],
					lfr_chain: result['lfr_chain'],
					location_code: result['location_code'],
					address: result['address'])
			end 
		end
	end

end
