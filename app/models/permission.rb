class Permission < ActiveRecord::Base
	belongs_to :role
	belongs_to :module_group
	validates :role_id,presence: true,:if => :already_exists?
	validates :module_group_id, presence: true

	private
		def already_exists?
 			if Permission.find_by(role_id: role_id,module_group_id: module_group_id) != nil
				errors.add(:error!, 'Permission already exists!')
			end
		end
end
