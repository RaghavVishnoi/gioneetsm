class CompetitionDetail < ActiveRecord::Base

	belongs_to :retailer

	validates :brand_name, presence: true
	validates :sale, presence: true
	validates :promoters, presence: true
	validate :is_sis
	validate :is_gsb 
end