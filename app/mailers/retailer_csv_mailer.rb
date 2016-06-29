class RetailerCsvMailer < ApplicationMailer

	default from: 'mkt@gionee.co.in'

	def share_file(email, path)
 	    attachments['csv'] = File.read(path)
	    mail(to: email, subject: 'Retailer Data')
	 end

end
