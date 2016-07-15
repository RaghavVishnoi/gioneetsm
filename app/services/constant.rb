class Constant
	require 'securerandom'
	
	def self.to_lang(result)
		case result
		when true
			'Yes'
		when false
			'No'
		end
	end

	def self.to_sub(result)
		case result
		when 1
			'Yes'
		when 0
			'No'
		when -1
			'N/A'
		when 2
			'Escalate to TL'
		end
	end

	def self.required_pieces(result)
		case result
		when 'X','x','*'
			'No pieces in stock'
		when '-','~'
			'No piece is required'
		else
			result
		end
	end

	def self.status(value)
		case value
		 when 1
		 	'Active'
		 when 0
			'Inactive'
		end
	end


	
 
	def self.time(start_date,end_date)		 
 		days = ((Time.parse(end_date.to_s) - Time.parse(start_date.to_s)) / (24 * 60 * 60)).to_f
 		if days < 1
			hours = days*24
 			if hours < 1
				minutes = days * 24 * 60
 				if minutes < 1
					'Just Now'
				else
					minutes.to_i.to_s+" minutes ago"
				end
			else
				hours.to_i.to_s+" hours ago"
			end
		else 
			days.to_i.to_s+" days ago"
		end	
	end


 
	def self.password
		SecureRandom.hex(6)
	end

	def self.token
		SecureRandom.hex(20)
	end

	def self.tempCode(data)
 		tmpData = {}
		if data == nil
			tmpData[:tmpcode] = "TEMPRT00001"
			tmpData[:tmpcount] = 1
		else
			tmpcount = data.tmpcount	
			tmpData[:tmpcode] = "TEMPRT"+('%05d' %(tmpcount.to_i + 00001)).to_s
			tmpData[:tmpcount] = tmpcount.to_i + 1
		end
		tmpData
	end 

end