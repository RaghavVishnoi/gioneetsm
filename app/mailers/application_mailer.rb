class ApplicationMailer < ActionMailer::Base
  default from: "anikaittiwari@gmail.com"
  layout 'mailer'

  # def forgot_password_mail(email,password)
  # 	subject = "Forgot password"
  # 	@password = password
  # 	mail(to: email,subject: subject )
  # end

end
