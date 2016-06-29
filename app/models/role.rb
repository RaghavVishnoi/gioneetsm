class Role < ActiveRecord::Base

 	 has_many :permit_roles
	 has_many :associated_roles, :dependent => :destroy
	 has_many :permissions
	 has_many :children,foreign_key: 'child_id',:class_name => "UserParent"

	 def self.per_roles(roles)
	 	if roles.any?{|role| ADMIN_ROLES.include?(role)}
	 		if roles.include?('superadmin')
	 			Role.where.not(name: 'superadmin')
	 		elsif roles.include?('Gionee Admin')
	 			Role.where.not(name: ADMIN_ROLES)
	 		end 				
	 	else
		 	@roles = []
		 	roles.each{|role| @roles.push(PermitRole.where(parent_role: role).pluck(:child_role))}
		 	Role.where(id: @roles)
		end 	
	 end

	 def self.user_listing(roles)
	 	users = []
		asst_roles = AssociatedRole.joins(:role).where('name IN (?)',roles)
		User.where(id: asst_roles.pluck(:object_id)) 	 	
 	 end
	 
	 def self.users_select(users)
	 	users.map {|user| [user_select(user),user.id]}	
	 end

	 def self.user_select(user)
	 	"#{user.first_name} #{user.last_name} - #{user.roles.pluck(:name).join(',')}"
	 end

	 # def self.users(role)
	 # 	Role.find_by(name: role).associated_roles.map{|asst_role| [asst_role.object.first_name+" "+asst_role.object.last_name,asst_role.object.id]}
	 # end

	 
	 # def self.download_user_data(user)
	 # 	role = User.user_roles(user.id).join(",")
	 # 	case role
	 # 		when 'superadmin','Gionee Manager'
	 # 			state = State.all.pluck(:name)
	 # 		when 'ND Manager','ND Admin'
	 # 			state = user.user_states.pluck(:state_id)
	 # 			state = State.where(id: state).pluck(:name)	
	 # 	end
		#  	Retailer.where(state: state)
	 # end
end
