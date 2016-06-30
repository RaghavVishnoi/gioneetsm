class CompetitionDetail < ActiveRecord::Base

	belongs_to :retailer

	validate :brand_name
	validate  :sale
	validate :promoter
	validate :is_sis
	validate :is_gsb 
end