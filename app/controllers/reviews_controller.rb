class ReviewsController < ApplicationController

	def create_review
		@user=User.find_by_id(params[:user_id])
		if @user.present?
			 @review=Review.create(:title=>params[:title],:content=>params[:content],:user_id=>@user.id,:subcategory_id=>params[:subcategory_id])
			 render :json => { :response_code => 200, :response_message => "Review are!!",:review=>@review.as_json(except: [:created_at,:updated_at,:image]) }
		else
			render :json => { :response_code => 500, :response_message => "something wrong"}
		end
	end

	def my_review
		@user=User.find_by_id(params[:user_id])
		if @user.present?
			@subcat=Subcategory.find_by_id(params[:subcategory_id])
			
	end
end
