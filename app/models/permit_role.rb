class PermitRole < ActiveRecord::Base
	belongs_to :parent,class_name: 'Role',foreign_key: 'parent_role'
	belongs_to :child,class_name: 'Role',foreign_key: 'child_role'

	validates :parent_role,presence: true,:if => :is_exists?
	validates :child_role, presence: true


	private
		def is_exists?
 			if PermitRole.find_by(parent_role: parent_role,child_role: child_role) != nil
				errors.add(:error!, 'Permission already exists!')
			end
		end
end
