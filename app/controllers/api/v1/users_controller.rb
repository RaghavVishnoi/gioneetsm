class Api::V1::UsersController < ApplicationController
	skip_before_action :authenticate_user, :except => [:destroy]
 	before_action :set_user, only: [:show, :edit, :update, :destroy]
	
	 def change_password 
	    @user = find_user_for_update
	    if @user != nil
		    if @user.authenticated?(params[:old_password])
		   	    if params[:password] == params[:confirm_password]
			   	    if @user.update_attribute(:password,params[:password])
			 			Activity.add_activity(@user,'forgot_password','')
						sign_in @user
						render :json => {result: true,status: 201,message: "Password successfully updated!"}
					else
						render :json => {result: false,status: INVALID_CREDENTAILS_STATUS,message: @user.errors.full_messages} 
					end 
				else
					render :json => {result: false,status: INVALID_CREDENTAILS_STATUS,message: 'Password and confirm password does not match!'}
				end	
			else
 				render :json => {result: false,status: INVALID_CREDENTAILS_STATUS,message: 'Old password does not match!'}
			end
		else
 			render :json => {result: false,status: INVALID_TOKEN_STATUS,message: 'Invalid token!'}
		end	    
 	 end
 
 	 def update
 	 	@user = set_user
 	 	@user.attributes = user_params
		@user.skip_password_validation = true
		if @user.save
			render :json => {result: true,:object => @user}
		else
			render :json => {result: false,status: INVALID_CREDENTAILS_STATUS,:object => @user.errors.full_messages}
		end		
	end

    private
		def set_user
      		@user = User.find_by(remember_token: params[:remember_token])
    	end

    	def user_params
			params.require(:user).permit(:email,:password,:password_confirmation,:first_name,:last_name,:mobile_number,:landline_number,:office_number ,:profile,:role_ids,:location_code,:account,{:state_ids => []},:user_reporting_id )
    	end

    	def find_user_by_remember_token
			User.find_by(remember_token: params[:remember_token])
		end

		def find_user_for_update
			find_user_by_remember_token
		end

		 

 end
