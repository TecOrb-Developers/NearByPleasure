class SubcategoriesController < ApplicationController
	def show
		@subcat=Subcategory.find_by_id(params[:id])
  	@subcat.images.present? ? @images = @subcat.images.pluck(:name) :  @images = ["/assets/club1.jpg","/assets/club2.jpg","/assets/club3.jpg","/assets/club1.jpg"]
	end
	def index
		if params[:search_category].present? 
			@cat = Category.find_by_id(params[:search_category]) 
	  	params[:search_location].present? ? @subcat = @cat.subcategories.where(:city=>params[:search_location]).sample(24) : @subcat = @cat.subcategories.sample(24)
		else
			@cat= Category.new
			@sc1 = Subcategory.where("category_id=?",1).limit(10)
			@sc2 = Subcategory.where("category_id=?",2).limit(10)
			@sc3 = Subcategory.where("category_id=?",3).limit(10)
			@subcat=@sc1+@sc2+@sc3
		end
	end
end
