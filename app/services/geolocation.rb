class Geolocation

	def self.retailer_exists(lat,lng,location_code)
 		retailers = Retailer.where(location_code: location_code)
 		@location = Location.where(object_type: 'Retailer',object_id: retailers.pluck(:id))
		retailers = []
		@location.each do |location|
		distance = Geolocation.distance(lat.to_f, lng.to_f,location[:lat] ,location[:lng]).to_kilometers
 			if distance <= RADIUS.to_f && location.object != nil
			   retailers.push(ResponseData.retailer(location.object))
			end
		end
		retailers
	end

	def self.distance(slat,slng,dlat,dlng)
		Haversine.distance(slat,slng,dlat ,dlng)
	end

	

end