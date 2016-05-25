class TalksController < ApplicationController

	def create_talk
		if params[:user_id].present? and params[:title].present? and params[:content].present?
			@user=User.find_by_id(params[:user_id])
			if @user.present?
				@talk=Talk.create(:title=>params[:title],:content=>params[:content],:admin_id=>params[:user_id])
				@talk_user=TalkUser.create(:user_id=>@talk.admin_id,:talk_id=>@talk.id)
			  render :json => { :response_code => 200, :response_message => "talks create successfully!!",:talk=>@talk.as_json(except: [:created_at,:updated_at]) }
	    else
			  render :json => { :response_code => 500, :response_message => "Something went wrong!!" }
	    end
	  else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
	  end
	end

 def all_talk
	@talks=Talk.all.paginate(:page => params[:page], :per_page => params[:per_page])
	  @result=[]
		@talks.each do |e|
			@user=User.find_by_id(e.admin_id)
		  @result<< e.attributes.merge(:user => @user.as_json(except: [:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) )
    end
	  render :json => { :response_code => 200,:response_message => "All talks!!",:talks=>@result}
  end

	def my_talk
		if params[:user_id].present?
			@talks=Talk.where(:admin_id=>params[:user_id]).paginate(:page => params[:page], :per_page => params[:per_page])
			render :json => { :response_code => 200, :response_message => "your talks!!",:talk=>@talks.as_json(except: [:created_at,:updated_at,:admin_id]) }
	  else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
	  end
	end

	def remove_talk
		if params[:user_id].present?
			@talk=Talk.find_by_id_and_admin_id(params[:talk_id],params[:user_id])
			if @talk
				@talk.destroy
			end
	    render :json => { :response_code => 200, :response_message => "talk deleted" }
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end
end
