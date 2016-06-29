class ApplicationController < ActionController::Base
  include Clearance::Controller
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session
  before_action :authenticate_user

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

private
    def authenticate_user
      unless logged_in?
        respond_to do |format|
          format.html { redirect_to :sign_in, alert: 'You need to login' }
          format.json { render :json => { :result => false,status: 401 ,:errors => { :messages => ["User not found"] } } }
        end
      end
    end

    def find_user
      if params[:remember_token]
        @user = User.find_by(:remember_token => params[:remember_token])
      elsif session[:user_id]
        @user = User.find_by(:id => session[:user_id])
        token_expiry @user
      end
      if @user != nil
        token_expiry @user
      end
    end

    def token_expiry user  
      if user.token_expiry != nil
        if user.token_expiry < Time.now
          render :json => { :result => false,status: 401,:errors => { :messages => ["Token Expire"] } } 
        else
          user
        end
      else
        user
      end
    end

    def logged_in?
      !!current_user || find_user
    end


 
end
