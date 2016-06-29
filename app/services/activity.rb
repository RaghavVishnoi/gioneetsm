class Activity
	
 
	def	self.add_activity(user,activity_type,other)
		UserActivity.create!(user_id: user.id,user_type: user.roles.first.name  ,message: message(user,activity_type,other),activty_type: activity_type)
	end

	def self.message(user,type,other)
		case type
		when 'login'
			"#{User.full_name(user)} has successfully logged in at #{Time.now}" 
		when 'request'
			"#{User.full_name(user)} has submitted a request for #{other} "		
 		when 'signup'
			"#{User.full_name(user)} has created a user with name #{User.full_name(other)} and role #{other.roles.first.name} at #{Time.now}"
		when 'logout'
			"#{User.full_name(user)} has successfully logout at #{Time.now}"
 		when 'reset_password'
			"#{User.full_name(user)} your Password has been successfully updated"
		when 'forgot_password'
			"#{User.full_name(user)} your Password has been successfully change"
		end

 
		end 
 	 

end