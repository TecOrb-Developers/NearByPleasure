class SessionsController < ApplicationController
	def index
    render :layout=>"empty"	
	end

	def login
		if params[:email].present? and params[:password].present?
			@user=User.find_by_email(params[:email])
			if @user && @user.authenticate(params[:password])
				flash[:notice]="Successfull login"
				session[:user_id]=@user.id
				respond_to do |format|
				  format.html { redirect_to root_path  }
				  format.json { render :json => {:response_code=> 200,:message => "Successfully logged in",:user=>@user.as_json(except: [:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) }	}					
				end
			else
				flash[:notice]="Unauthorized access!!"
				respond_to do |format|
				  format.html { redirect_to user_login_path  }
					format.json { render json: { :response_code => 500,:response_message => "Unauthorized access!!" } }
				end
			end
		else
			flash[:notice]="Please provide all required parameters"
			respond_to do |format|
			  format.html { redirect_to user_login_path  }
				format.json { render json: { :response_code => 500,:response_message => "Please provide all required parameters" } }
		  end
		end
	end

	def forgot_password
		if params[:email].present?
			@user=User.find_by_email(params[:email])
			if @user
				@token="#{['A','b','C','d','@','-','A'].sample(2).join('')}#{Time.now.to_i}#{['z','s','w','m',1,2,3].sample(4).join('')}"
        @user.update_attributes(:forget_password_token=>@token)
        UserMailer.forgot_password(@user).deliver_now
				render :json => {:response_code => 200,:message => "Password recovery email sent to your email." }
			else
				render :json => { :response_code => 500,:response_message => "User does not exists." }
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def forgot_view
		@user=User.find_by_id_and_forget_password_token(params[:user_id],params[:token])
		if !@user
			render :json => { :response_code => 500,:response_message => "Unauthorized Access." }
		else
			render :layout =>"blank_application"
		end
	end

	def update_password
		if params[:password].present? and params[:password_confirm].present?
			@user = User.find_by_id(params[:user_id])
			if @user and (params[:password].strip == params[:password_confirm].strip)
				@user.update_attributes(:password=>params[:password],:forget_password_token=>'')
				render :json => {:response_code => 200,:message => "Password has been updated successfully.",:user=>@user.as_json(except: [:id,:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) }
			else
				render :json => { :response_code => 500,:response_message => "Unauthorized access!!" }
			end
		else
				render :json => { :response_code => 500,:response_message => "Password does not matched!!" }
		end
	end
	def user_logout
		session[:user_id]=nil
		redirect_to :back
	end
end
