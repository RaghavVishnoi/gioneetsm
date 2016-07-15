
class UsersController < ApplicationController
  
  before_action :authenticate_user	
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  PER_PAGE = 30
  
	def index
		session[:prev_url] = request.fullpath
  		@users = User.users(current_user,params).order("id").paginate(per_page: PER_PAGE,page: (params[:page] || 1)) 
  	end

	def new
		@user=User.new
	end

	def create
		@user=User.new(user_params)
			if @user.save
				User.create_zuser(@user,user_params[:user_reporting_id])
				Activity.add_activity(current_user,'signup',@user)
				redirect_to users_path,notice: "User created successfully"
			else
				render 'new'
			end
	end

	def edit
	end

	def show
 	end

	def update
		@user.attributes = user_params
		@user.skip_password_validation = true

		if @user.save
   			User.update_image(@user,user_params) if user_params[:profile] != nil
			redirect_to users_path, notice: "Record updated successfully"
		else
			render :edit
		end
	end

	def change_status
       user = User.where(id: params[:id])
       case user.first.status
          when 1
             user.update_all(status: 0)
          when 0
             user.update_all(status: 1)
        end
       render :json => {result: true,status: user.status}
       	
    end

    def reporting_manager
    	@user = User.parent_location_code(Role.find(params[:role]).name)
    	render :json => {result: true,object: @user}
    end



     def change_password 
	    @user = User.find_by(remember_token: params[:users_reset_password_path][:token])    
	   	if @user.update(:password => params[:users_reset_password_path][:password],:password_confirmation => params[:users_reset_password_path][:password_confirmation])  
	        Activity.add_activity(@user,'reset_password','')
	        flash[:notice] = "password successfully updated"
	        redirect_to users_path
     	 else
	         @token = @user.remember_token 
	         render  users_reset_password_path
      end
	     
 	 end

	def reset_password
	    @user = User.new
	end
 
    def mum
 		zsales = User.mum_by_rd(params[:rd])
  		render :json => {result: true,object: zsales}
 	end

 	def rds
 		rds = User.rd_by_nd(params[:nd])
 		render :json => {result: true,object: rds}
 	end
 
	private
		def set_user
      		@user = User.find(params[:id])
    	end

		def user_params
			params.require(:user).permit(:email,:password,:password_confirmation,:first_name,:last_name,:mobile_number,:landline_number,:office_number ,:profile,:role_ids,:location_code,:account,{:state_ids => []},:user_reporting_id )
		end

end


