class PasswordController < ApplicationController
	def forget_password
  	render :layout =>"blank_application"
  end
  def forgot_business_password
  	if params[:forgot][:email].present?
			@user=User.find_by_email(params[:forgot][:email])
			if @user
				@token="#{['A','b','C','d','@','-','A'].sample(2).join('')}#{Time.now.to_i}#{['z','s','w','m',1,2,3].sample(4).join('')}"
        @user.update_attributes(:forget_password_token=>@token)
        ForgetMailer.forgot_password(@user).deliver_now
        flash[:notice]="mail sent on your email"
        redirect_to business_forget_password_path
			else
			  flash[:notice]="user not exist"
			  redirect_to business_forget_password_path
			end
		else
			flash[:notice]="please enter your email id"
			redirect_to business_forget_password_path
		end
  end

  def business_forgot_view
		@user=User.find_by_id_and_forget_password_token(params[:user_id],params[:token])
		if !@user
			flash[:notice]="Unauthorized access"
			redirect_to business_forget_password_path
		else
			redirect_to change_business_password_path
		end
	end

	def change_business_password
		@user=User.find_by_id_and_forget_password_token(params[:user_id],params[:token])
		if !@user
			flash[:notice]="Unauthorized access"
			redirect_to business_forget_password_path
		else
		 render :layout =>"blank_application"
		end
	end 

	def change_password
		if params[:password][:password].present? and params[:password][:repeat_password].present?
			@user = User.find_by_id(params[:user_id])
			if @user and (params[:password][:password].strip == params[:password][:repeat_password].strip)
				@user.update_attributes(:password=>params[:password][:password],:forget_password_token=>'')
				flash[:notice]="password change successfully"
				redirect_to business_forget_password_path
				else
					flash[:notice]="Unauthorized access"
					redirect_to business_forget_password_path
			end
		else
				flash[:notice]="password not change successfully"
		end
	end
end
