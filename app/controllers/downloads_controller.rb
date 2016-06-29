class DownloadsController < ApplicationController

	def index
	end

	def create
		if params[:from].length == 0 || params[:to].length == 0
			render :json => 0
		else
			@location_code = Download.location_code(current_user,params)
 			case params[:type]
			when 'WOD Expansion'
				@downloads = Download.retailers(params[:from],params[:to],@location_code)
			when 'Daily Sales Beat'
				@downloads = Download.sales_beat(params[:from],params[:to],@location_code)
			when 'Gionee Good Morning'
				@downloads = Download.target(params[:from],params[:to],@location_code)
			end
			if @downloads != 0
				render :json => @downloads.split('public')[1]
			else
				render :json => 0
			end
		end
 	end

  	
 
 

end