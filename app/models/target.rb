class Target < ActiveRecord::Base

	after_create :add_activity

	has_many :focus_models
	accepts_nested_attributes_for :focus_models, :allow_destroy => true
	
	belongs_to :user
	belongs_to :zuser,foreign_key: 'location_code'

	validates :mum, presence: true
	validates :rds, presence: true
	validates :date, presence: true
	validates :fos, presence: true
	validates :value_target, presence: true
	validates :volume_target, presence: true
	validates :imei, presence: true
	validates :location_code, presence: true

	def self.targets(current_user,params)
		location_code = LocationCode.location_codes(current_user)
		if params[:search] != nil
			Target.where(location_code: location_code[:mum_location_code]).where('location_code like ?',"%#{params[:search]}%")
		else
			Target.where(location_code: location_code[:mum_location_code])
		end
	end

	private 
		def add_activity
			Activity.add_activity(self.user,'request','target')
		end

end
