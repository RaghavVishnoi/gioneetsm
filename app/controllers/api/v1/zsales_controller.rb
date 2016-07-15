class Api::V1::ZsalesController < ApplicationController

	def search
		if params[:type] == 'location'
			@retailer = Geolocation.retailer_exists(params[:lat],params[:lng],location_code(user))		
 			if @retailer.length != 0
 				render :json => {:result => true,:object => @retailer}
 			else
 				render :json => {:result => false,status: INVALID_CREDENTAILS_STATUS,:message => 'No retailer found!'}
 			end
 		elsif params[:type] == 'code'
 			@retailer = Retailer.find_by('(lower(retailer_code) = ? OR lower(tmpcode) = ?) AND location_code IN (?)',params[:retailer_code].downcase,params[:retailer_code].downcase,location_code(user))
 			if @retailer != nil
 				render :json => {:result => true,:object => @retailer}
 			else
 				@retailer = Zsale.find_by('lower(retailer_code) = ? AND location_code IN (?)',params[:retailer_code].downcase,location_code(user))
 			    if @retailer != nil
 			    	render :json => {result: true,:object => @retailer}
 			    else	
 					render :json => {:result => false,status: INVALID_CREDENTAILS_STATUS,:message => 'No retailer found!'}
 				end
 			end
 		end
 	end

 	def assignment
 		location_codes = Zuser.where(email: User.find_by(remember_token: params[:remember_token]).email).pluck(:location_code)
 		shops = Zsale.where(location_code: location_codes).select(:retailer_code,:sales_channel)
 		render :json => {result: true,object: shops}
 	end

 	def rds
 		retailer = Zsale.find_by(location_code: params[:location_code])
 		if retailer != nil
 			render :json => {result: true,object: retailer.sales_channel}
 		else
 			render :json => {result: true,object: ''}
 		end		
 	end	

 	

private
 	def user
 		User.find_by(remember_token: params[:remember_token])
 	end

 	def location_code(user)
 		Zuser.where(email: user.email).pluck(:location_code)
 	end

end  