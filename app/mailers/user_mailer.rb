class UserMailer < ApplicationMailer
	def confirmation(user)
		@user = user
    p"-------#{@user}"
    mail( :to => @user.email, :subject => 'Escort app Confirmation email' )
	end

	def forgot_password(user)
		@user = user
    mail( :to => @user.email, :subject => 'Escort app Forgot password Link' )
	end
end
