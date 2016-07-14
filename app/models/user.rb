class User < ActiveRecord::Base
  include Clearance::User
  require 'fileutils'

  attr_accessor :profile,:password_confirmation, :skip_password_validation ,:user_reporting_id

  after_create :add_image
  
  after_create :notify_user
   
  has_many :associated_roles, :as => :object, :dependent => :destroy
  has_many :roles, :through => :associated_roles
  has_one :image,:as => :object, :dependent => :destroy
  has_many :user_states, :as => :user, :dependent => :destroy
  has_many :states, :through => :user_states
  has_many :user_reporting_managers,foreign_key: 'reporting_manager_id',:class_name => "UserReportingManager"
  has_many :user_reporting_managers,foreign_key: 'user_id',:class_name => "UserReportingManager"
  has_many :retailers
  has_many :sales_beats
  has_many :targets
  has_many :user_activities
  #belongs_to :zuser,:class => 'Zuser',foreign_key: 'location_code'

  validates :first_name,presence: true
  validate  :last_name

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,presence: true,length:
             {minimum: 6,maximum: 50 },
             uniqueness: {case_sensitive: false},
             format: {with: VALID_EMAIL_REGEX}

 
  validate :mobile_number
                 
  
  validate :landline_number
  
  validate :office_number
  
  validates :location_code, presence: true 
  #validates :designation_id, :presence => true,:unless => :is_exists?
  validates :password, :presence => true ,unless: :skip_password_validation
  validates_confirmation_of :password, :if => ->{ password.present? },unless: :skip_password_validation
  validate :state_ids
 
  validates :role_ids,presence: true

  def self.users(current_user,params)
    if params[:role] != nil && params[:role] != ""
      users = role_users(Role.where(id: params[:role].split(',')))
      if params[:search] != nil && params[:search] != ""
        Zuser.users(current_user).where(id: users.pluck(:id)).where('email like ? OR lower(location_code) like ?',"%#{params[:search]}%","%#{params[:search].downcase}%")
      else
        Zuser.users(current_user).where(id: users.pluck(:id))
      end
    else
      if params[:search] != nil && params[:search] != ""
        Zuser.users(current_user).where('email like ? OR lower(location_code) like ?',"%#{params[:search]}%","%#{params[:search].downcase}%")
      else
        Zuser.users(current_user)
      end
    end
  end

  def self.permit_roles(roles)
    if roles.pluck(:name).any?{|role| ADMIN_ROLES.include?(role)}
      if roles.pluck(:name).include?('superadmin')
        Role.where.not(name: 'superadmin')
      elsif roles.pluck(:name).include?('Gionee Admin')
        Role.where.not(name: ADMIN_ROLES)
      end         
    else
      @roles = []
      roles.each{|role| @roles.push(PermitRole.where(parent_role: role.id).pluck(:child_role))}
      Role.where(id: @roles)
    end 
  end
   
  def self.is_permit(group,current_user)
  	groups = []	
  	permission(current_user).each{|per| groups.push(per.module_group.name)}
    groups.include?(group)
  end

  def self.permission(current_user)
  	Permission.where(role_id: current_user.roles.pluck(:id))
  end

  
  def self.update_image(user,params)
    Image.delete_directory(user)
    image = params[:profile]
      @image = Image.new(lat: 0.0,lng: 0.0,image: image,object_type: 'Profile',:object_id => user.id)      
      if @image.save
        path = ImageSerializer.new(@image, :root => false).image_url
        full_path = path.to_s
        user.update(profile_path: full_path)
      end
  end

  def self.user_roles(id)
      user = User.find_by(:id => id)           
      associated_roles = AssociatedRole.where(:object_id => id) 
      role = []
        associated_roles.each do |associated_role|
          role.push(associated_role.role.name)   
        end
         role
  end

  def self.full_name(user)
    if user.last_name != nil
      user.first_name + " " + user.last_name
    else
      user.first_name
    end
   
  end


  def self.report_to(role_id)
    role = Role.find(role_id)
    pRole = role.children.pluck(:parent_id)
    AssociatedRole.where(role_id: pRole).map{|associated_role| associated_role.object}
  end

  def self.mum_listing(nd,role)
    users = User.where(account: nd).joins(:roles).where('roles.name = ?',role)
  end

 
  def self.rd_by_nd(nd)
    Zsale.where(nd: nd).pluck(:sales_channel).uniq.sort
  end

  def self.mum_by_rd(rd)
    Zuser.where(status: 0,location_code: Zsale.where(sales_channel: rd).pluck(:location_code)).uniq.select(:person_name,:location_code)
  end

  def self.nds(current_user)
    if current_user.roles.any?{|role| ADMIN_ROLES.include?(role.name)}
      Zsale.all.pluck(:nd).uniq
    elsif current_user.roles.pluck(:name).include?('ND Admin')
      [current_user.account]
    else
      mum_location_code = Zuser.permit_mum(current_user).pluck(:location_code).uniq  
      Zsale.where(location_code: mum_location_code).pluck(:nd).uniq
    end
  end

  def self.role_users(roles)
    User.joins(:roles).where('roles.name IN (?)',roles.pluck(:name))
  end


 def self.reporting_manager(user)
  if !user.roles.any?{|role| ADMIN_ROLES.include?(role)} && !user.roles.include?('ND Admin')
    Zuser.where(email: user.email).pluck(:parent_location_code,:person_name)
  else
    []
  end
 end


 def self.location_code(user)
  if !user.roles.any?{|role| ADMIN_ROLES.include?(role)} && !user.roles.include?('ND Admin')
    Zuser.where(email: user.email).pluck(:location_code)
  else
    []
  end
 end

 def self.parent_location_code(role)
    case role
    when 'TSM'
      @parents = Zuser.where(location_type: 'ASM')
      if @parents.size != 0
       @parents.map{|parent| [parent.person_name+"-"+parent.location_code+"-"+parent.location_code,parent.location_code]}
      else
        []
      end
    when 'ASM'
       @parents = Zuser.where(location_type: 'ZSM')
       if @parents.size != 0
         @parents.map{|parent| [parent.person_name+"-"+parent.location_code,parent.location_code]}
      else
        []
      end
    when 'ZSM'
       @parents = Zuser.where(location_type: 'CBH')
        if @parents.size != 0
         @parents.map{|parent| [parent.person_name+"-"+parent.location_code,parent.location_code]}
        else
          []
        end
    when 'CBH'
       @parents = User.where(status: 1).joins(:roles).where('roles.name IN (?)',['ND Admin'])
        if @parents.size != 0
         @parents.map{|parent| [parent.first_name+"-"+parent.location_code,parent.location_code]}
        else
          []
        end 
    when 'ND Admin'
       @parents = User.where(status: 1).joins(:roles).where('roles.name IN (?)',['Gionee Admin'])
        if @parents.size != 0
         @parents.map{|parent| [parent.first_name+"-"+parent.location_code,parent.location_code]}
        else
          []
        end  
    end
    
 end
 
 
  def self.mum_request(user,user_type,activity_type)
        user.user_activities.where(activty_type: activity_type,user_type: user_type) 
  end
   
  
 
 
 def self.children(role,current_user)
  user = {}
    if current_user.roles.pluck(:name).include?('ND Admin')     
      case role.name
      when 'TSM'
        mum = Zuser.location_code('ND Admin',current_user)
        User.where(email: Zuser.where(location_code: mum.pluck(:location_code)).pluck(:email)).uniq
      when 'ASM'
        mum = Zuser.location_code('ND Admin',current_user)
        asm = Zuser.where(location_code: mum.pluck(:parent_location_code).uniq)
        User.where(email: Zuser.where(location_code: asm.pluck(:location_code)).pluck(:email)).uniq
      when 'ZSM'
        mum = Zuser.location_code('ND Admin',current_user)
        asm = Zuser.where(location_code: mum.pluck(:parent_location_code).uniq)
        zsm = Zuser.where(location_code: asm.pluck(:parent_location_code).uniq)
        User.where(email: Zuser.where(location_code: zsm.pluck(:location_code)).pluck(:email)).uniq
      when 'BH'
        []
      when 'CBH'
        mum = Zuser.location_code('ND Admin',current_user)
        asm = Zuser.where(location_code: mum.pluck(:parent_location_code).uniq)
        zsm = Zuser.where(location_code: asm.pluck(:parent_location_code).uniq)
        #bh = Zuser.where(location_code: zsm.pluck(:parent_location_code).uniq)
        cbh = Zuser.where(location_code: zsm.pluck(:parent_location_code).uniq)
       User.where(email: Zuser.where(location_code: cbh.pluck(:location_code)).pluck(:email)).uniq
      end  
    elsif current_user.roles.pluck(:name).include?('CBH')
      location_code = Zuser.location_code('CBH',current_user)
      case role.name
      when 'TSM'
        User.where(location_code: location_code[:mum_location_code],status: 1)
      when 'ASM'
        User.where(location_code: location_code[:asm_location_code],status: 1)
      when 'ZSM'
        User.where(location_code: location_code[:zsm_location_code],status: 1)
      when 'BH'
        []
      end
    elsif current_user.roles.pluck(:name).include?('BH')
      location_code = Zuser.location_code('BH',current_user)
      case role.name
      when 'ZSM'
        User.where(location_code: location_code[:zsm_location_code],status: 1)
      when 'ASM'
        User.where(location_code: location_code[:zsm_location_code],status: 1)
      when 'TSM'
        User.where(location_code: location_code[:mum_location_code],status: 1)
      end  
    elsif current_user.roles.pluck(:name).include?('ZSM')
      location_code = Zuser.location_code('ZSM',current_user)
      case role.name
      when 'ASM'
        User.where(location_code: location_code[:asm_location_code],status: 1)
      when 'TSM'
        User.where(location_code: location_code[:mum_location_code],status: 1)
      end
    elsif current_user.roles.pluck(:name).include?('ASM')  
      location_code = Zuser.location_code('ASM',current_user)
      case role.name
      when 'TSM'
        User.where(location_code: location_code[:mum_location_code],status: 1)
      end
    else
      role_users(Role.where(name: role.name))
    end 
 end

 def self.create_zuser(user,parent_location_code)
      parent_location_code = user.user_reporting_id
      if user.roles.pluck(:name).include?('ND Admin')
        @location_type = 'ND Admin'
      elsif user.roles.pluck(:name).include?('CBH')
        @location_type = 'CBH'
      elsif user.roles.pluck(:name).include?('BH')
        @location_type = 'BH'
      elsif user.roles.pluck(:name).include?('ZSM')
        @location_type = 'ZSM'
      elsif user.roles.pluck(:name).include?('ASM')
        @location_type = 'ASM'
      elsif user.roles.pluck(:name).include?('TSM')
        @location_type = 'TSM'
      else
        @location_type = 'Gionee Admin'
      end
          Zuser.create!(
          location_code: user.location_code,
          location_type: @location_type,
          parent_location_code: if parent_location_code != nil then  parent_location_code else 'Gionee' end,
          email: user.email,
          person_name: user.first_name+" "+user.last_name,
          mobile_number: user.mobile_number,
          last_updated_on: Time.now,
          status: 1
          )
    end

    def self.update_zuser(user,reporting_manager)
      puts "user #{user.to_json}"
      puts "reporting manager #{reporting_manager}"
    end 

 
 private
    def add_image
      image = self.profile
      if self.profile != nil
        @image = Image.new(lat: 0.0,lng: 0.0,image: image,object_type: 'Profile',:object_id => self.id)      
        if @image.save
          path = ImageSerializer.new(@image, :root => false).image_url
          full_path = path.to_s
          self.update(profile_path: full_path)
        end
      end
    end

    # def add_user_reporting
    #   UserReportingManager.create!(user_id: self.id,reporting_manager_id: user_reporting_id)
    # end

    
    def notify_user
     # UserMailer.user_data(self).deliver_now
    end


 
   # def is_exists?
   #    if designation_id == nil || designation_id == 0
   #      self.designation_id = 5
   #    end
   # end

end
