class ResponseData

	def self.user_data(object)
		user = {}
		zuser = Zuser.where(email: object.email)
		user[:first_name] = object.first_name
		user[:last_name] = object.last_name
		user[:email] = object.email
		user[:mobile_number] = if object.mobile_number != nil then object.mobile_number else "" end
		user[:location_code] = zuser.pluck(:location_code) if zuser != nil
		user[:remember_token] = object.remember_token
		user[:landline_number] = if object.landline_number != nil then object.landline_number else "" end
		user[:office_number] = if object.office_number != nil then object.office_number else "" end
		user
	end

	def self.retailer(shop)
		if shop != nil
			retailer = {}
			retailer[:retailer_code] = if shop.tmpcode == nil then shop.retailer_code else shop.tmpcode end
			retailer[:retailer_name] = shop.retailer_name
			retailer[:state] = if shop.state != nil then shop.state else "" end
			retailer[:city] = if shop.city != nil then shop.city else "" end
			retailer[:address] = if shop.address != nil then  shop.address else "" end
			retailer[:retailer_phone] = if shop.retailer_phone != nil then shop.retailer_phone else "" end
			retailer
		end	
	end

 
end