class CategoriesController < ApplicationController

	def all_category
	 @categories=Category.all
   render :json => { :response_code => 200, :response_message => "All categories",:category=>@categories.as_json(except: [:created_at,:updated_at]) }
	end
end
