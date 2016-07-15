class CrashReportMailer < ActionMailer::Base
	default from: "info@gionee.co.in"
	
	def report(message)
		attachments['crash.doc'] = message
		mail(to: CRASH_REPORT_DEFAULT_EMAIL, subject: 'Crash Report')
	end

end
