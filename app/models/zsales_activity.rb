class ZsalesActivity < ActiveRecord::Base

	validates :location_code, presence: true
	validates :location_type, presence: true
	validates :person_name, presence: true
	validate :parent_location_code
	validates :email, presence: true
	validate  :mobile_number
	validate :employee_code
	validate  :last_updated_on
	validates :status, presence: true

	def self.add_activity(zuser)
		self.create!(
		 location_code: zuser.location_code, 
		 location_type: zuser.location_type, 
		 person_name: zuser.person_name, 
		 parent_location_code: zuser.parent_location_code, 
		 email: zuser.email, 
		 mobile_number: zuser.mobile_number,
		 employee_code: zuser.employee_code, 
		 last_updated_on: Time.now, 
		 status: zuser.status
		)
	end

	
end
