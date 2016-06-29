class Api::V1::SessionsController < ApplicationController
	skip_before_filter :require_login, only: [:create, :new, :destroy], raise: false
	skip_before_filter :authorize, only: [:create, :new, :destroy], raise: false
	skip_before_action :authenticate_user, :except => [:destroy]
	
	def create
		@user = authenticate(params)
		sign_in(@user) do |status|
			if status.success?  && @user != nil && @user.status == 1
				if @user.roles.exists?(name: 'TSM')
					@user.update_attributes!(:last_login_time => Time.now,:token_expiry => Time.now + 1.day,:password => params[:session][:password],:remember_token => Constant.token)
					Activity.add_activity(current_user,'login','')
 					render :json => {:result => true,:object => ResponseData.user_data(@user)}
				else
					render :json => { :result => false,:status => INVALID_TOKEN_STATUS, :message => 'You are not authorize person'}
				end
			else
			        render :json => { :result => false,:status => INVALID_TOKEN_STATUS, :message => 'Invalid Username or Password'}
 			end
		end
	end

	 
	def destroy
		sign_out	
		render :json => { :result => true,:status => GET_SUCCESS_STATUS, :message => 'Successfully logged out'}
	end

	 
end
