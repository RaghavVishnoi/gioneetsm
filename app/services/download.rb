class Download
	require 'fileutils'

	def self.retailers(from,to,location_code)	 
		if from == nil || to ==nil || Time.parse(from) > Time.parse(to)
			0
		else
			FileUtils.mkdir_p("#{Rails.root}/public/retailer_csv") unless Dir.exists?("#{Rails.root}/public/retailer_csv") 
			file ||= File.new retailer_path, "w+"
			file.puts retailer_header
 			@retailers = Retailer.where(location_code: location_code,updated_at: (Time.parse(from).to_date.beginning_of_day)..(Time.parse(to).to_date.end_of_day))			 
			if @retailers.length != 0
				@retailers.each do |retailer|    
					file.puts retailer_body(retailer)			 
		 		end
		 	end	
	 		file.close 
	 		retailer_path
 		end
	end

	def self.retailer_header
		['mum','retailer_name','retailer_code','temp_code','state','city','address','location_code','lat','long','landmark','store_area','store_monthly_sales_volume','store_monthly_sales_value','generated on','IMEI','brand_name','sales quantity','sales value','promoters','is_sis','is_gsb','brand_name','sales quantity','sales value','promoters','is_sis','is_gsb','brand_name','sales quantity','sales value','promoters','is_sis','is_gsb','brand_name','sales quantity','sales value','promoters','is_sis','is_gsb','brand_name','sales quantity','sales value','promoters','is_sis','is_gsb','brand_name','sales quantity','sales value','promoters','is_sis','is_gsb'].flatten.join(',')
	end

	def self.retailer_body(retailer)
		if retailer.location == nil
			@lat = 0.0
			@lng = 0.0
		else
			@lat = retailer.location.lat
			@lng = retailer.location.lng
		end
		[retailer.mum,retailer.retailer_name,retailer.retailer_code,retailer.tmpCode,retailer.state,retailer.city,retailer.address,retailer.location_code,@lat,@lng,retailer.landmark,retailer.store_area,retailer.store_monthly_sales_volume,retailer.store_monthly_sales_value,retailer.created_at.strftime("%d %b %Y"),retailer.imei,retailer.competition_details.pluck(:brand_name,:volume,:sale,:promoters,:is_sis,:is_gsb)].flatten.map {|v| "\"#{v.to_s.gsub('"', '""')}\"" }.join(',')
	end

	def self.retailer_path
		"public/retailer_csv/"+Time.now.strftime("%d-%m-%y_%H-%M").to_s+".csv"
	end

	def self.sales_beat(from,to,location_code)
		if from == nil || to ==nil || Time.parse(from) > Time.parse(to)
			0
		else
			FileUtils.mkdir_p("#{Rails.root}/public/sales_beat_csv") unless Dir.exists?("#{Rails.root}/public/sales_beat_csv") 
			sfile ||= File.new sales_beat_path, "w+"
			sfile.puts sales_beat_header
			@sales_beat = SalesBeat.where(location_code: location_code,created_at: (Time.parse(from).to_date.beginning_of_day)..(Time.parse(to).to_date.end_of_day))			 
			if @sales_beat.length != 0
				@sales_beat.each do |sales_beat|    
					sfile.puts sales_beat_body(sales_beat)			 
		 		end
		 	end
	 		sfile.close 
	 		sales_beat_path
	 	end
	end

	def self.sales_beat_header
		['MUM/FOS','RDS','date','RT Code','location_code','lat','long','are all sis properly maintained?','are all gsb properly maintained?','is GCS Present?','IMEI','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count','Model Name','Stock Count'].flatten.join(',')
	end

	def self.sales_beat_body(sales_beat)
		if sales_beat.location == nil
			@lat = 0.0
			@lng = 0.0
		else
			@lat = sales_beat.location.lat
			@lng = sales_beat.location.lng
		end
		[sales_beat.mum,sales_beat.rds,sales_beat.date,sales_beat.retailer_code,sales_beat.location_code,@lat,@lng,Constant.to_sub(sales_beat.is_sis_maintained),Constant.to_sub(sales_beat.is_gsb_maintained),Constant.to_sub(sales_beat.gcs_present),sales_beat.imei,sales_beat.stocks.pluck(:mod_name,:count)].flatten.map {|v| "\"#{v.to_s.gsub('"', '""')}\"" }.join(',')
	end

	def self.sales_beat_path
		"public/sales_beat_csv/"+Time.now.strftime("%d-%m-%y_%H-%M").to_s+".csv"
	end

	def self.target(from,to,location_code)
		if from == nil || to == nil || Time.parse(from) > Time.parse(to)
			0
		else
			FileUtils.mkdir_p("#{Rails.root}/public/target_csv") unless Dir.exists?("#{Rails.root}/public/target_csv") 
			tfile ||= File.new target_path, "w+"
			tfile.puts target_header
			@targets = Target.where(location_code: location_code,created_at: (Time.parse(from).to_date.beginning_of_day)..(Time.parse(to).to_date.end_of_day))			 
			if @targets.length != 0
				@targets.each do |target|    
					tfile.puts target_body(target)			 
		 		end
		 	end
	 		tfile.close 
	 		target_path
	 	end
	end

	def self.target_header
		['Name of the MUM','Name of the RDS','location_code','Date','Name of FoS','IMEI','Value target for the day','Volume target for the day','Plan remarks','Review remarks','Focus Model','Volume Sale','Focus Model','Volume Sale','Focus Model','Volume Sale','Focus Model','Volume Sale','Focus Model','Volume Sale'].flatten.join(',')
	end

	def self.target_body(target)
		[target.mum,target.rds,target.location_code,target.date,target.fos,target.imei,target.value_target,target.volume_target,target.plan_remarks,target.review_remarks,target.focus_models.pluck(:target_model_name,:sale)].flatten.join(',')
	end

	def self.target_path
		"public/target_csv/"+Time.now.strftime("%d-%m-%y_%H-%M").to_s+".csv"
	end

	def self.location_code(current_user,params)
		if current_user.roles.pluck(:name).include?('TSM')
			Zuser.where(email: current_user.email).pluck(:location_code).uniq
		else
			if params[:nd] != nil
				if params[:rd] != nil
					if params[:location_code] != nil
						params[:location_code]
					else
						Zsale.where(sales_channel: params[:rd]).pluck(:location_code)
					end
				else
					Zsale.where(nd: params[:nd]).pluck(:location_code).uniq
				end
			else
				Zuser.permit_mum(current_user).pluck(:location_code).uniq  
			end
		end	
	end

 

	

end