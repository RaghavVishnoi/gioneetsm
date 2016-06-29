class State < ActiveRecord::Base
	has_many :user_state 

	def self.permit_state(user)
		if user.roles.pluck(:name).any?{|role| ALL_PERMISSION.include?(role)}
			State.all.pluck(:name,:id)
		else
			state_id = user.user_states.pluck(:state_id)
			puts "ssssss#{state_id}"
			State.where(id: state_id).pluck(:name,:id)
		end				
	end

	def self.state_user(role,user)
		permit_states = permit_state_id(user)
   		users = User.joins(:roles).where('roles.id IN (?)',Role.per_roles(role).pluck(:id))
 		users.joins(:states).where('states.id IN (?)',permit_states).uniq
 	end

 	def self.users(role,user)
		permit_states = permit_state_id(user)
   		users = User.joins(:roles).where('roles.id = ?',role)
 		users.joins(:states).where('states.id IN (?)',permit_states).uniq
 	end

	def self.permit_state_id(user)
		if user.roles.pluck(:name).any?{|role| ALL_PERMISSION.include?(role)}
			State.all.pluck(:id)
		else
			state_id = user.user_states.pluck(:state_id)
			State.where(id: state_id).pluck(:id)
		end				
	end
end


