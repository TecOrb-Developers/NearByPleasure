class ReviewsController < ApplicationController

	def create_review
		if params[:title].present? and params[:content].present? and params[:user_id].present? and params[:subcategory_id].present?
			@user=User.find_by_id(params[:user_id])
			if @user
				@subcat = Subcategory.find_by_id(params[:subcategory_id])
				if @subcat
					@review=@subcat.reviews.create(:title=>params[:title],:content=>params[:content],:user_id=>@user.id)
					render :json => { :response_code => 200, :response_message => "Review successfully added",:review=>@review.as_json(except: [:created_at,:updated_at,:image]) }
				else
					render :json => { :response_code => 500, :response_message => "Sub category does not exists"}
				end
			else
				render :json => { :response_code => 500, :response_message => "User does not exists"}
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def my_reviews
		@user=User.find_by_id(params[:user_id])
		if @user
			@subcat=Subcategory.find_by_id(params[:subcategory_id])
			if @subcat
				@reviews=@subcat.reviews.where(:user_id=>@user.id).paginate(:page => params[:page], :per_page => params[:per_page])
				render :json => { :response_code => 200, :response_message => "All Review!!",:review=>@reviews.as_json(except: [:created_at,:updated_at,:image]) }
			else
				render :json => { :response_code => 500, :response_message => "Subcategory not exist"}
			end
		else
			render :json => { :response_code => 500, :response_message => "User not exist"}
		end
	end

	def all_reviews
		if params[:subcategory_id].present?
			@subcat=Subcategory.find_by_id(params[:subcategory_id])
			if @subcat
				@reviews=@subcat.reviews.paginate(:page => params[:page], :per_page => params[:per_page])
				render :json => { :response_code => 200, :response_message => "All Review!!",:review=>@reviews.as_json(except: [:created_at,:updated_at,:image]) }
			else
				render :json => { :response_code => 500, :response_message => "Subcategory not exist"}
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def user_reviews
		@user = User.find_by_id(params[:user_id])
		if @user
			@reviews=@user.reviews.paginate(:page => params[:page], :per_page => params[:per_page])
			render :json => { :response_code => 200, :response_message => "All Review!!",:review=>@reviews.as_json(except: [:created_at,:updated_at,:image]) }
		else
			render :json => { :response_code => 500, :response_message => "User does not exist"}
		end
	end
end
