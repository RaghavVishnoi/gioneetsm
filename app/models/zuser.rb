class Zuser < ActiveRecord::Base

 	
	has_many :parent_locations,:class => 'Zuser',foreign_key: 'parent_location_code', primary_key: 'parent_location_code'

	has_many :retailers,foreign_key: 'location_code'
	has_many :sales_beats,foreign_key: 'location_code'
	has_many :targets,foreign_key: 'location_code'
	has_many :users,foreign_key: 'location_code'
	has_many :zsales,foreign_key: 'location_code', primary_key: 'location_code'

	validates :location_code, presence: true,uniqueness: true
	validates :location_type, presence: true
	validates :person_name, presence: true
	validate  :parent_location_code
	validates :email, presence: true
	validate :mobile_number
	validate :employee_code
	validate :last_updated_on
	validates :status, presence: true

	def self.update(url,start_date,end_date)
 		@result = Response.users(url,start_date,end_date)[0]['data']	
 		@result.each do |result|
			zuser = self.find_by(location_code: result['LocationCode'])
			if zuser != nil
				ZsalesActivity.add_activity(zuser)
				zuser.update!(
					 location_code: result['LocationCode'], 
					 location_type: result['LocationType'], 
					 person_name: result['PersonName'], 
					 parent_location_code: result['ParentLocationCode'], 
					 email: result['Email'], 
					 mobile_number: result['MobileNo'],
					 employee_code: result['EmployeeCode'], 
					 last_updated_on: result['LastModifiedOn'], 
					 status: result['Status']
					)
			else
				@zuser = self.new(
					 location_code: result['LocationCode'], 
					 location_type: result['LocationType'], 
					 person_name: result['PersonName'], 
					 parent_location_code: result['ParentLocationCode'], 
					 email: result['Email'], 
					 mobile_number: result['MobileNo'],
					 employee_code: result['EmployeeCode'], 
					 last_updated_on: result['LastModifiedOn'], 
					 status: result['Status']
					)
				if @zuser.save!
					create_user(@zuser)
				end
				
			end 
		end
	end

	def self.users(current_user)
		if current_user.roles.pluck(:name).include?('ND Admin')
			mum = location_code('ND Admin',current_user)
 			asm = self.where(location_code: mum.pluck(:parent_location_code).uniq)
 			zsm = self.where(location_code: asm.pluck(:parent_location_code).uniq)
			bh = self.where(location_code: zsm.pluck(:parent_location_code).uniq)
			cbh = self.where(location_code: bh.pluck(:parent_location_code).uniq)
			location_code = mum.pluck(:location_code).uniq+zsm.pluck(:location_code).uniq+bh.pluck(:location_code)+cbh.pluck(:location_code).uniq
		elsif current_user.roles.pluck(:name).include?('CBH')
		 	location_code = location_code('CBH',current_user)
 			location_code = location_code[:bh_location_code]+location_code[:zsm_location_code]+location_code[:mum_location_code]+location_code[:asm_location_code]
		elsif current_user.roles.pluck(:name).include?('BH')
			location_code = location_code('BH',current_user)
 			location_code = location_code[:zsm_location_code]+location_code[:mum_location_code]+location_code[:asm_location_code]
 		elsif current_user.roles.pluck(:name).include?('ZSM')
			location_code = location_code('ZSM',current_user)
			location_code = location_code[:mum_location_code]+location_code[:asm_location_code] 
		end
		if current_user.roles.any?{|role| ADMIN_ROLES.include?(role.name)}	
 			User.role_users(Role.per_roles(current_user.roles))			
 		else
			User.where(location_code: location_code)			
		end
	end

	def self.location_code(role,current_user)
		current_location_code = self.where(email: current_user.email).pluck(:location_code)
		case role
		when 'ND Admin'
			self.joins(:zsales).where('zsales.nd = ?',current_user.account)
		when 'CBH'
			location_code = {}
			#bh_location_code = self.where(parent_location_code: current_location_code).pluck(:location_code)
			zsm_location_code = self.where(parent_location_code: current_location_code).pluck(:location_code)
			asm_location_code = self.where(parent_location_code: zsm_location_code).pluck(:location_code)
			mum_location_code = self.where(parent_location_code: asm_location_code).pluck(:location_code)
			#location_code[:bh_location_code] = bh_location_code
			location_code[:zsm_location_code] = zsm_location_code
			location_code[:asm_location_code] = asm_location_code
			location_code[:mum_location_code] = mum_location_code
			location_code
		when 'BH'
			location_code = {}
			zsm_location_code = self.where(parent_location_code: current_location_code).pluck(:location_code)
			asm_location_code = self..where(parent_location_code: zsm_location_code).pluck(:location_code)
			mum_location_code = self.where(parent_location_code: asm_location_code).pluck(:location_code)
			location_code[:zsm_location_code] = zsm_location_code
			location_code[:asm_location_code] = asm_location_code
			location_code[:mum_location_code]= mum_location_code
			location_code
		when 'ZSM'
			location_code = {}
			asm_location_code = self.where(parent_location_code: current_location_code).pluck(:location_code)
			mum_location_code = self.where(parent_location_code: asm_location_code).pluck(:location_code)
			location_code[:asm_location_code] = asm_location_code
			location_code[:mum_location_code] = mum_location_code
			location_code
		when 'ASM'
			location_code = {}
			mum_location_code = self.where(parent_location_code: current_location_code).pluck(:location_code)
			location_code[:mum_location_code] = mum_location_code
			location_code
		when 'TSM'
			location_code = {}
			location_code[:mum_location_code] = current_location_code
			location_code
		end		
		 
	end

	def self.permit_mum(current_user)
		current_location_code = self.where(email: current_user.email).pluck(:location_code)
		if current_user.roles.pluck(:name).include?('CBH')
			bh_location_code = self.where(parent_location_code: current_location_code).pluck(:location_code)
			zsm_location_code = self.where(parent_location_code: bh_location_code).pluck(:location_code)
			asm_location_code = self..where(parent_location_code: zsm_location_code).pluck(:location_code)
			self.where(parent_location_code: asm_location_code)
		elsif current_user.roles.pluck(:name).include?('BH')
			zsm_location_code = self.where(parent_location_code: current_location_code).pluck(:location_code)
			asm_location_code = self..where(parent_location_code: zsm_location_code).pluck(:location_code)
			self.where(parent_location_code: asm_location_code)
		elsif current_user.roles.pluck(:name).include?('ZSM')
			asm_location_code = self.where(parent_location_code: current_location_code).pluck(:location_code)
			self.where(parent_location_code: asm_location_code)

		elsif current_user.roles.pluck(:name).include?('ASM')
			self.where(parent_location_code: current_location_code)	
		elsif current_user.roles.pluck(:name).include?('TSM')
			self.where(location_code: current_location_code)	
		else
			self.all
		end			
	end

	def self.create_user(user)
 		if !User.exists?(email: user.email)
			password = 'Lakshya123'
			User.create!(
				first_name: user.person_name,
				email: user.email,
				location_code: user.location_code,
				role_ids: Role.find_by('lower(name) = ?',user.location_type.downcase).id,
				mobile_number: user.mobile_number,
				password: password,
				password_confirmation: password
			)
		end
	end


	 


	
end
