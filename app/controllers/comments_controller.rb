class CommentsController < ApplicationController

	def create_comment
		@user=TalkUser.find_by_user_id(params[:user_id])
		@talk=TalkUser.find_by_talk_id(params[:talk_id])
		if @user.present?
			@comment=Comment.create(:content=>params[:content],:user_id=>@user.user_id,:talk_id=>@talk.talk_id)
			render :json => { :response_code => 200, :response_message => "Comment create successfully!!",:comment=>@comment.as_json(except: [:created_at,:updated_at]) }
		else
			render :json => { :response_code => 500, :response_message => "please signup than create comment!!" }
		end
	end
end
