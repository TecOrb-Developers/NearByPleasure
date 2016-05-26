class TitlesController < ApplicationController

	def search_title
		@title=Subcategory.find_by_title(params[:title])
		if @title.present?
		  @titles=Subcategory.where("title ILIKE ?","%#{@title.title}%").paginate(:page => params[:page], :per_page => 2)
			render :json => { :response_code => 200, :response_message => "Subcategory",:Subcategory=>@titles.as_json(except: [:created_at,:updated_at])}
		else
			render :json => { :response_code => 500, :response_message => "something wrong"}
		end
	end

end
