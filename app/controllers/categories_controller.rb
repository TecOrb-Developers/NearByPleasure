class CategoriesController < ApplicationController

	def all_category
	 @categories=Category.all.paginate(:page => params[:page], :per_page => params[:per_page])
     render :json => { :response_code => 200, :response_message => "All categories",:category=>@categories.as_json(except: [:created_at,:updated_at]) }
	end

	def find_category
		if params[:category_id].present?
			@category = Category.find_by_id(params[:category_id])
			if @category				
				render :json => { :response_code => 200, :response_message => "Category details",:category=>@category.as_json(except: [:created_at,:updated_at])}
			else
				render :json => { :response_code => 500, :response_message => "Category does not exists"}
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end
end
