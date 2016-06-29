class UserMailer < ActionMailer::Base
	default from: "info@gionee.co.in"

	def user_data(user)
		@user = user
		mail(to: user.email, subject: 'User Details')
	end

	def password(password,email)
		@password = password
		mail(to: email, subject: 'Password update')
	end
end