class Api::V1::PasswordsController < ApplicationController
	skip_before_filter :require_login, only: [:create, :edit, :new, :update], raise: false
	skip_before_filter :authorize, only: [:create, :edit, :new, :update], raise: false
	before_filter :ensure_existing_user, only: [:edit, :update]
	
  	skip_before_action :authenticate_user, :except => [:destroy]


	def create
		user = find_user_for_create
		if user != nil
			password = Constant.password
			user.update(password: password)
			UserMailer.password(password,user.email).deliver_now
			render :json => {:result => true,:message => 'Password has been sent successfully' }
		else
			render :json => { :result => false,status: INVALID_CREDENTAILS_STATUS, :message => 'Invalid email id!' }
		end
		
	end

	def update
		@user = find_user_for_update
		if @user.update_password password_reset_params
			render :json => {:result => true,:message => "Password successfully updated"}	
		end
	end

	private
		def deliver_email(user)
			mail = ::ClearanceMailer.change_password(user)
			if Gem::Version.new(Rails::VERSION::STRING) >= Gem::Version.new("4.2.0")
				mail.deliver_later
			else
				mail.deliver
			end
		end

		def password_reset_params
			if params.has_key? :user
				ActiveSupport::Deprecation.warn %{Since locales functionality was added, accessing params[:user] is no longer supported.}
				params[:user][:password]
			else
				params[:password_reset][:password]
			end
		end

		def find_user_by_id_and_confirmation_token
			User.find_by(confirmation_token: params[:user][:confirmation_token])
		end

		def find_user_for_create
			User.find_by(email: params[:email])
		end


		def find_user_for_update
			find_user_by_id_and_confirmation_token
		end

		def ensure_existing_user
			unless find_user_by_id_and_confirmation_token
				flash_failure_when_forbidden
				render template: "passwords/new"
			end
		end

		def flash_failure_when_forbidden
			flash.now[:notice] = translate(:forbidden,
			scope: [:clearance, :controllers, :passwords],
			default: t('flashes.failure_when_forbidden'))
		end

		def flash_failure_after_update
			flash.now[:notice] = translate(:blank_password,
			scope: [:clearance, :controllers, :passwords],
			default: t('flashes.failure_after_update'))
		end

		

end