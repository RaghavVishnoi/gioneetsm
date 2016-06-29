class UserState < ActiveRecord::Base
	belongs_to :state
	belongs_to :user, :polymorphic => true
end
