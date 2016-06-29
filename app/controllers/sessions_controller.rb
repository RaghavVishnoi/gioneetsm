class SessionsController < ApplicationController
 
	layout 'login'
	skip_before_filter :require_login, only: [:create, :new, :destroy], raise: false
	skip_before_filter :authorize, only: [:create, :new, :destroy], raise: false
	skip_before_action :authenticate_user, :except => [:destroy]
	
	def create
		@user = authenticate(params)
		sign_in(@user) do |status|
			if status.success?  && @user!= nil && @user.status == 1

				@user.update_attribute(:last_login_time, Time.now)
				Activity.add_activity(current_user,'login','')
 				if @user.roles.pluck(:name).include?('TSM')
					respond_to do |format|
				      format.html { redirect_to downloads_path }
				      format.json { render :json => { :result => true,:user => @user,:messages => "Successfully logged in" } }
				    end	
				else
					respond_to do |format|
				      format.html { redirect_to retailers_path }
				      format.json { render :json => { :result => true,:user => @user,:messages => "Successfully logged in" } }
				    end	
				end
					
			else

				respond_to do |format|

			      format.html { redirect_to :sign_in,notice: "Invalid email and password combination!"}
			      format.json { render :json => { :result => false, :message => 'Invalid Username or Password'}}
			    end
			end
		end
	end

	def destroy
		Activity.add_activity(current_user,'logout','')
		current_user.update_attribute(:last_logout_time, Time.now)
		sign_out
		respond_to do |format|
			format.html { redirect_to root_path }
			format.json { render :json => { :result => false, :message => 'Successfully logged out'} }
	    end
	end

end
