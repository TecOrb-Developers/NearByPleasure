class UsersController < ApplicationController
	def signup
		if params[:password]==params[:confirm_password]
			if !User.exists?(:email=>params[:email])
				@token="#{['A','b','C','d','@','-','A'].sample(2).join('')}#{Time.now.to_i}#{['z','s','w','m',1,2,3].sample(4).join('')}"
	  	  @user=User.create(:fname=>params[:fname],:lname=>params[:lname],:contact=>params[:contact],:gender=>params[:gender],:email=>params[:email],:password=>params[:password],:confirmation_token=>@token, :is_confirm=>false)
        if @user
          UserMailer.confirmation(@user).deliver_now
					render :json => { :response_code => 200, :response_message => "Successfully signup!!",:user=>@user.as_json(except: [:created_at,:password_digest,:updated_at,:confirmation_token,:forget_password_token]) }
        else
				  render :json => { :response_code => 500, :response_message => "Something went wrong!!" }
        end
			else
				render :json => { :response_code => 500, :response_message => "Email already exists." }
			end
		else
			render :json => { :response_code => 500, :response_message => "Password does not matched." }
		end
	end

	def confirm
		@user=User.find_by_id_and_confirmation_token(params[:user_id],params[:token])
		if @user
			@user.update_attributes(:is_confirm=>true)
			render :json => {:message => "Your account successfully confirmed.",:you=>@user.as_json(except: [:id,:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) }
		else
			render :json => { :response_code => 500,:response_message => "Unauthorized Access." }
		end
	end

	def socialauth
		if params[:provider_id].present? and params[:provider_name].present? and params[:email].present?
			@user = User.find_by_email(params[:email])
			if !@user
				@user = User.create(:fname=>params[:fname],:lname=>params[:lname],:contact=>params[:contact],:gender=>params[:gender],:email=>params[:email],:image=>params[:profile_pic],:password=>"#{params[:provider_id]}.#{params[:provider_name]}@tecorb",:is_confirm=>true) 
			end
			@soc = @user.socialauths.where("provider_name=? and provider_id=?",params[:provider_name],params[:provider_id]).first
			@user.update_attributes(:is_confirm=>true)
			if @soc.present?
				render :json => {:message => "Successfully logged in",:user=>@user.as_json(except: [:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) }
			else
				@user.socialauths.create(:provider_id=>params[:provider_id],:provider_name=>params[:provider_name])
				render :json => {:message => "Successfully logged in",:user=>@user.as_json(except: [:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) }
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end
end
