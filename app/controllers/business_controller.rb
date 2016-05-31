class BusinessController < ApplicationController

	def index
		render :layout =>"blank_application"
	end
	
	def new
	 render :layout =>"blank_application"
	end

	def payment_mode
		render :layout =>"blank_application"
	end

	def user_signin
		@user=User.find_by_email(params[:user_login][:email])
		if !@user
		 	if params[:user_login][:password]==params[:user_login][:repeat_password]
		 	  @user=User.create(:lname=>params[:user_login][:lname],:fname=>params[:user_login][:fname],:contact=>params[:user_login][:contact],:email=>params[:user_login][:email],:gender=>params[:user_login][:gender],:password=>params[:user_login][:password],:is_business=>"true")
		 	  flash[:notice]="user successfully login"
		 	  if params[:type]!="paid"
		 	    redirect_to welcome_path(encrypt(@user.id))
		 	  else
		 	  	render 'new'
		 	  end
		  else
		   	flash[:notice]="password and repeat password does not match"
		   	render  'new'
		  end
		else 
		 	@user.update_attributes(:lname=>params[:user_login][:lname],:fname=>params[:user_login][:fname],:contact=>params[:user_login][:contact],:email=>params[:user_login][:email],:gender=>params[:user_login][:gender],:password=>params[:user_login][:password],:is_business=>"true")
		 	redirect_to welcome_path(encrypt(@user.id))
		end
	end

 def welcome
 	@user=User.find_by_id(decrypt(params[:user_id]))
 	render :layout =>"blank_application"
 end


 def create
	@user=User.find_by_email(params[:user_login][:email])
	if @user && @user.authenticate(params[:user_login][:password])
		session[:business_id]=@user.id
		flash[:notice]="welcome"
		redirect_to  welcome_path(encrypt(@user.id))
	else
		flash[:notice]="password not correct"
		redirect_to  welcome_path(encrypt(@user.id))
	end
 end

  def logout
		session[:business_id]=nil
		redirect_to payment_path
	end

end
