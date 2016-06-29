class SalesBeat < ActiveRecord::Base

	attr_accessor :image

	has_one :location,:as => :object, :dependent => :destroy
	accepts_nested_attributes_for :location, :allow_destroy => true

	has_many :stocks,:as => :object, :dependent => :destroy
	accepts_nested_attributes_for :stocks, :allow_destroy => true

	belongs_to :user
	belongs_to :zuser,foreign_key: 'location_code'
   
	after_create :add_image

	after_create :add_activity

	validates :mum, presence: true
	validates :rds, presence: true
	validates :date, presence: true
	validates :retailer_code, presence: true
	validate :stock_count
	validate :is_sis_maintained 
	validate :is_gsb_maintained 
	validates :imei, presence: true
	validates :location_code, presence: true


	def self.sales_beats(current_user,params)
		location_code = LocationCode.location_codes(current_user)
		if params[:search] != nil
			SalesBeat.where(location_code: location_code[:mum_location_code]).where('location_code like ?',"%#{params[:search]}%")
		else
			SalesBeat.where(location_code: location_code[:mum_location_code])
		end
	end


	def self.images(sales_beat)
		Image.where(object_type: 'SalesBeat',object_id: sales_beat.id)
	end

	private
		def add_image
 			image = self.image
			Image.create!(lat: 0.0,lng: 0.0,image: image,object_type: 'SalesBeat',:object_id => self.id)			
		end


		def add_activity
			Activity.add_activity(self.user,'request','sales_beat')
		end
	 

end
