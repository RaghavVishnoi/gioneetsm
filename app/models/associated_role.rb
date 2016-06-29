class AssociatedRole < ActiveRecord::Base
	belongs_to :object, :polymorphic => true
	belongs_to :role
end
