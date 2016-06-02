class UsersController < ApplicationController
	require 'base64'
	require 'open-uri'
	def signup
		if params[:email].present? and params[:password].present? and params[:fname].present?
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
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
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
			@img=nil
			if params[:profile_pic].present?
				img = open("#{params[:profile_pic]}")
				@im=Base64.encode64(img.read)
				m=Cloudinary::Uploader.upload("data:image/png;base64,#{@im}")
				@img=m["url"]
			end
			if !@user
				@user = User.create(:fname=>params[:fname],:lname=>params[:lname],:contact=>params[:contact],:gender=>params[:gender],:email=>params[:email],:image=>@img,:password=>"#{params[:provider_id]}.#{params[:provider_name]}@tecorb",:is_confirm=>true) 
			else
				@user.update_attributes(:fname=>params[:fname],:lname=>params[:lname],:contact=>params[:contact],:gender=>params[:gender],:image=>@img,:is_confirm=>true)
			end
			@soc = @user.socialauths.where("provider_name=? and provider_id=?",params[:provider_name],params[:provider_id]).first
			if !@soc.present?
				@user.socialauths.create(:provider_id=>params[:provider_id],:provider_name=>params[:provider_name])
			end
			render :json => {:message => "Successfully logged in",:user=>@user.as_json(except: [:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]).merge(:provider_id=>params[:provider_id],:provider_name=>params[:provider_name]) }
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def profile
		@user = User.find_by_id(params[:user_id])
		if @user
			render :json => {:response_code => 200,:message => "Profile fetched",:user=>@user.as_json(except: [:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) }
		else
			render :json => { :response_code => 500,:response_message => "User does not exists." }
		end
	end

	def update_profile
		@user = User.find_by_id(params[:user_id])
		if @user
			@img=nil
			if params[:profile_pic_in_base_sixty_four].present?
				m=Cloudinary::Uploader.upload("data:image/png;base64,#{params[:profile_pic_in_base_sixty_four]}")
				@img=m["url"]
			end
			@user.update_attributes(:fname=>params[:fname],:lname=>params[:lname],:contact=>params[:contact],:gender=>params[:gender],:image=>@img)
			render :json => {:response_code => 200,:message => "Profile updated",:user=>@user.as_json(except: [:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) }
		else
			render :json => { :response_code => 500,:response_message => "User does not exists." }
		end
	end


	def update
		@user=User.find_by_id(params[:id])
		@user.update_attributes(:fname=>params[:user][:fname],:lname=>params[:user][:lname],:contact=>params[:user][:contact])
		redirect_to profile_path(encrypt(@user.id))
	end
end
