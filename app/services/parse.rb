class Parse

	def self.sales_beat(params,user_id)
 		data = params[:data]
 		salesBeat = JSON.parse(data)['sales_beat']
 		# if SalesBeat.exists?(mum: salesBeat['mum'],retailer_code: salesBeat['retailer_code'])

 		# else

 		# end
 		im = params[:image]
 		img = {}
 		img['image'] = im
 		salesBeat.merge!(img)
 		salesBeat.merge(user_id: user_id)
 		sBeat = SalesBeat.new(salesBeat.merge(user_id: user_id))
 		slBeat = sBeat.save!
 	end

end