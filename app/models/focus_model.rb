class FocusModel < ActiveRecord::Base

	belongs_to :target

	validates :target_model_name, presence: true
	validates :sale, presence: true

end


