class CommentsController < ApplicationController

	def create_comment
		if params[:user_id].present? and params[:talk_id].present? and params[:content].present?
			@talk=Talk.find_by_id(params[:talk_id])
			@user=User.find_by_id(params[:user_id])
			if @user and @talk
				if !@talk.talk_users.exists?(:user_id=>@user.id)
					@join=@talk.talk_users.create(:user_id=>@user.id)
				end
				@comment=@talk.comments.create(:content=>params[:content],:user_id=>@user.id)
				render :json => { :response_code => 200, :response_message => "Comment created successfully!!",:comment=>@comment.as_json(except: [:created_at,:updated_at]) }
			else
				render :json => { :response_code => 500, :response_message => "User or Talk does not exists" }
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end
end
