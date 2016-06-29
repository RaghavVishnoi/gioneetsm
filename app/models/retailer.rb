class Retailer < ActiveRecord::Base

	after_create :add_activity
 	
	has_many :competition_details, :dependent => :destroy
	accepts_nested_attributes_for :competition_details, :allow_destroy => true

	has_one :location,:as => :object, :dependent => :destroy
	accepts_nested_attributes_for :location, :allow_destroy => true

	belongs_to :user
	belongs_to :zuser,foreign_key: 'location_code'

	validates :retailer_name, presence: true
	validate   :retailer_code
	validates :address, presence: true
	validate :landmark
	validates :store_area, presence: true
	validates :store_monthly_sales_volume, presence: true
	validates :store_monthly_sales_value, presence: true
	validates :imei, presence: true
	validates :state, presence: true
	validates :city, presence: true
	validate  :mum
	validate  :retailer_phone
	validates :location_code, presence: true


 
	def self.retailers(current_user,params)
		location_code = LocationCode.location_codes(current_user)
 		if params[:search] != nil
 			Retailer.where(location_code: location_code[:mum_location_code]).where('location_code like ?',"%#{params[:search]}%")
 		else
 			Retailer.where(location_code: location_code[:mum_location_code])
 		end
	end

 	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |product|
	      csv << product.attributes.values_at(*column_names)
	    end
	  end
	end

	

	private
		def boolean
		    attribute ? 'Yes' : 'No'
		end

		def add_activity
			Activity.add_activity(self.user,'request','retailer')
		end

end
