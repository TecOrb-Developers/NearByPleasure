class TalksController < ApplicationController

	def create_talk
		@user=User.find_by_id(params[:user_id])
		if @user.present?
			@talk=Talk.create(:title=>params[:title],:content=>params[:content],:admin_id=>params[:user_id])
			@talk_user=TalkUser.create(:user_id=>@talk.admin_id,:talk_id=>@talk.id)
		  render :json => { :response_code => 200, :response_message => "talks create successfully!!",:talk=>@talk.as_json(except: [:created_at,:updated_at]) }
    else
		  render :json => { :response_code => 500, :response_message => "Something went wrong!!" }
    end
	end

 def all_talk
	@talks=Talk.all
	  @result=[]
		@talks.each do |e|
			@user=User.find_by_id(e.admin_id)
		  @result<< e.attributes.merge(:user => @user.as_json(except: [:created_at,:updated_at,:confirmation_token,:password_digest,:forget_password_token]) )
    end
	  render :json => { :response_code => 200,:response_message => "All talks!!",:talks=>@result}
  end

	def my_talk
		@talks=Talk.where(:admin_id=>params[:admin_id])
		if @talks.present?
		  render :json => { :response_code => 200, :response_message => "your talks!!",:talk=>@talks.as_json(except: [:created_at,:updated_at]) }
    else
		  render :json => { :response_code => 500, :response_message => "Something went wrong!!" }
    end
	end
	def remove_talk
		@user=Talk.find_by_admin_id(params[:user_id]).destroy
		@talk=Talk.find_by_id(params[:talk_id]).destroy
    render :json => { :response_code => 500, :response_message => "talk deleted" }
	end
end
