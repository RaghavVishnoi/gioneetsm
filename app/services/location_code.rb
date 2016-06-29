class LocationCode

	def self.location_codes(current_user)
	    if current_user.roles.pluck(:name).include?('ND Admin')     
	      location_code = {}
	      location_code[:mum_location_code] = Zuser.location_code('ND Admin',current_user).pluck(:location_code)	        
 	      location_code	
 	    elsif current_user.roles.pluck(:name).include?('CBH')
	      Zuser.location_code('CBH',current_user)      
	    elsif current_user.roles.pluck(:name).include?('BH')
	      Zuser.location_code('BH',current_user)
	    elsif current_user.roles.pluck(:name).include?('ZSM')
	      Zuser.location_code('ZSM',current_user)
	    elsif current_user.roles.pluck(:name).include?('ASM')  
	      Zuser.location_code('ASM',current_user)
	    elsif current_user.roles.pluck(:name).include?('TSM')  
	      Zuser.location_code('TSM',current_user)	
	    else
	      location_code = {} 	 
	      location_code[:mum_location_code] = Zuser.where(location_type: 'TSM').pluck(:location_code)
	      location_code
	    end
	end
end