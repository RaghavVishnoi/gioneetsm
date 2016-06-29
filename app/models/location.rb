class Location < ActiveRecord::Base

	belongs_to :object, :polymorphic => true

	validates :lat, presence: true
	validates :lng, presence: true
    validate :location
    
end