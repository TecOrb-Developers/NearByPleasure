class SubcategoriesController < ApplicationController
	
	def show
		@subcat=Subcategory.find_by_id(params[:id])
  	# @subcat.images.present? ? @images = @subcat.images.pluck(:name) :  @images = ["/assets/club1.jpg","/assets/club2.jpg","/assets/club3.jpg","/assets/club1.jpg"]
		if @subcat.category.name=="escort"
			@imgs = @subcat.images.pluck(:name)
			@images=[]
			if @imgs.present?
				@imgs.each do |i|
					@images << "http://tecorb.com/admin/Max/cityvibe/cityvibe/#{i}"
				end
			else
				@images << "http://tecorb.com/admin/Max/cityvibe/cityvibe/westhollywood-escorts-naomi-cruz-1732827.jpg"
			end
		elsif @subcat.category.name=="Strip Club"
			@images = ["/assets/club1.jpg","/assets/club2.jpg","/assets/club3.jpg","/assets/club1.jpg"]
		else
			@images = all_massage_image
		end
				
	end
	def index
		if params[:search_category].present? 
			@cat = Category.find_by_id(params[:search_category]) 
	  	params[:search_location].present? ? @subcat = @cat.subcategories.where(:city=>params[:search_location]).sample(40) : @subcat = @cat.subcategories.sample(40)
		else
			@cat= Category.new
			@sc1 = Subcategory.where("category_id=? and city=?",1,params[:search_location].present? ? params[:search_location] : "Columbus").limit(20)
			@sc2 = Subcategory.where("category_id=? and city=?",2,params[:search_location].present? ? params[:search_location] : "Columbus").limit(20)
			@sc3 = Subcategory.where("category_id=? and city=?",3,params[:search_location].present? ? params[:search_location] : "Columbus").limit(20)
			@subcat=@sc1+@sc2+@sc3
		end
	end
end
