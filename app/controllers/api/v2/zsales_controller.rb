class Api::V2::ZsalesController < ApplicationController

	def rds
 		retailer = Zsale.where('lower(location_code) = ?',params[:location_code].downcase).order('sales_channel asc')
  		render :json => {result: true,object: retailer.pluck(:sales_channel).uniq}
 	end

 	def assignment
 		location_codes = Zuser.where(email: User.find_by(remember_token: params[:remember_token]).email).pluck(:location_code)
 		shops = Zsale.where('location_code IN (?) AND sales_channel IN (?)',location_codes,params[:rds]).select(:retailer_code,:sales_channel,:retailer_name)
 		render :json => {result: true,object: shops}
 	end

end