class BusinessController < ApplicationController

	before_action :require_logged_in, only:[:welcome,:add_business_form,:add_business,:show,:my_business,:setting,:profile,:edit,:my_business_edit]

	def index
		render :layout =>"blank_application"
	end
	
	def new
	 render :layout =>"blank_application"
	end

	def payment_mode
		if !current_business_user
			render :layout =>"blank_application"
		else
			redirect_to welcome_path(encrypt(current_business_user.id))
		end
	end

	def user_signup
		@user=User.find_by_email(params[:user_signup][:email])
		if !@user
		 	if params[:user_signup][:password]==params[:user_signup][:repeat_password]
		 	  @user=User.create(:lname=>params[:user_signup][:lname],:fname=>params[:user_signup][:fname],:contact=>params[:user_signup][:contact],:email=>params[:user_signup][:email],:gender=>params[:user_signup][:gender],:password=>params[:user_signup][:password],:is_business=>"true")
		 	  flash[:notice]="user successfully login"
		 	  if params[:type]!="paid"
		 	  	session[:business_id]=@user.id
		 	    redirect_to welcome_path(encrypt(@user.id))
		 	  else
		 	  	render 'new'
		 	  end
		  else
		   	flash[:notice]="password and repeat password does not match"
		   	render  'new'
		  end
		else 
		 	@user.update_attributes(:lname=>params[:user_signup][:lname],:fname=>params[:user_signup][:fname],:contact=>params[:user_signup][:contact],:email=>params[:user_signup][:email],:gender=>params[:user_signup][:gender],:password=>params[:user_signup][:password],:is_business=>"true")
		 	session[:business_id]=@user.id
		 	redirect_to welcome_path(encrypt(@user.id))
		end

		# //render :layout =>"blank_application"

	end

 def welcome
 	@user=User.find_by_id(decrypt(params[:user_id]))
 	@categories=Category.all
 	# render :layout =>"application"
 end

 def create
	 @user=User.find_by_email(params[:user_login][:email])
	 if @user && @user.authenticate(params[:user_login][:password])
		 session[:business_id]=@user.id
		 flash[:notice]="welcome"
		 redirect_to  welcome_path(encrypt(@user.id))
	 else
		 flash[:notice]="password not correct"
		 redirect_to  :back
	 end
 end

  def logout
		session[:business_id]=nil
		redirect_to payment_path
	end

	def add_business_form
		@categories=Category.all
		render :layout =>"application"

	end

	def add_business
		@subcat=current_business_user.subcategories.create(:title=>params[:add_business][:title],:description=>params[:add_business][:description],:email=>params[:add_business][:email],:contact=>params[:add_business][:contact],:street_address=>params[:add_business][:street_address],:city=>params[:add_business][:city],:pin=>params[:add_business][:pin],:state=>params[:add_business][:state],:tag_line=>params[:add_business][:tag_line],:category_id=>params[:category],:rating=>params[:add_business][:rating])
		flash[:notice]="user successfully login"
		redirect_to business_path(encrypt(@subcat.id))
	end

  def show
  	@subcat=Subcategory.find_by_id(decrypt(params[:id]))
  	render :layout =>"application"
  end

  def my_business
  	@user=User.find_by_id(decrypt(params[:id]))
  	@subcats=@user.subcategories.all
  	render :layout =>"application"
  end

  def profile
  	@user=User.find_by_id(decrypt(params[:id]))
  	render :layout =>"application"
  end
  def setting
  	@user=User.find_by_id(decrypt(params[:id]))
  	render :layout =>"application"
  end

  def change_password
    @user = User.find_by_id(params[:id])
    if @user  && @user.authenticate(params[:reset_password][:current_password])
      if (params[:reset_password][:new_password])==(params[:reset_password][:new_repeat_password])
        @user.update_attributes(:password=>params[:reset_password][:new_password])
        flash[:success] = "Password successfully changed!"
        redirect_to  :back
      else
        flash[:error]="password not match"
        redirect_to :back
      end
    else
      flash[:error] = "Your old password was incorrect. Please try again."
      redirect_to :back
    end
  end

  def edit
  	@user=User.find_by_id(params[:id])
  	render :layout =>"application"
  end
  
  def my_business_edit
  	@business=Subcategory.find_by_id(params[:id])
  	@categories=Category.all
  	render :layout =>"application"
  end
  
end
