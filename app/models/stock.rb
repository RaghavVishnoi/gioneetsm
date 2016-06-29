class Stock < ActiveRecord::Base

	belongs_to :object, :polymorphic => true

	validates :mod_name, presence: true
	validates :count, presence: true
	 
end	