class Response

	def self.parse(url)
		response = HTTParty.get(url)
		JSON.parse(response.body)	
	end

	def self.accounts(url)
		json = parse(url)
		if json[STATUS] == SUCCESS
			array = []
			json[RESULT][ACCLIST].each {|result|  array.push(result[NAME])}
			array
		else
			[] 
		end
	end

	def self.zsales(url,start_date,end_date)
		url = url+'&start_date='+start_date+'&end_date='+end_date
		response = HTTParty.get(url)
		JSON.parse(response.body)
	end

 
	def self.users(url,start_date,end_date)
		url = url+'&BeginTime='+start_date+'&EndTime='+end_date
		response = HTTParty.get(url)
		JSON.parse(response.body)
 	end

 end