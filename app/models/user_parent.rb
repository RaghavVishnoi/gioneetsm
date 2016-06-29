class UserParent < ActiveRecord::Base
	belongs_to :parent,class_name: 'Role',foreign_key: 'parent_id'
	belongs_to :child,class_name: 'Role',foreign_key: 'child_id'
end
