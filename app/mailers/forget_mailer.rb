class ForgetMailer < ApplicationMailer
	def forgot_password(user)
		@user = user
    mail( :to => @user.email, :subject => 'Business Forgot password Link' )
	end
end
