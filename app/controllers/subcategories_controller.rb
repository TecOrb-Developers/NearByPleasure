class SubcategoriesController < ApplicationController
	def show
		@subcat=Subcategory.find_by_id(params[:id])
  	@subcat.images.present? ? @images = @subcat.images.pluck(:name) :  @images = ["/assets/club1.jpg","/assets/club2.jpg","/assets/club3.jpg","/assets/club1.jpg"]
	end
	def index
		params[:search_category].present? ? @cat = Category.find_by_id(params[:search_category]) : @cat= Category.find_by_name("escort")
	  params[:search_location].present? ? @subcat = @cat.subcategories.where(:city=>params[:search_location]).sample(24) : @subcat = @cat.subcategories.sample(24)
	end
end
