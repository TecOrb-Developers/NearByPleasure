class ApplicationMailer < ActionMailer::Base
	include Preventurl
  default from: "fun.all.here@gmail.com"

  layout 'mailer'
end
