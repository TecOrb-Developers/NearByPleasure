class SubcategoriesController < ApplicationController
	
	def show
		@subcat=Subcategory.find_by_id(params[:id])
  	# @subcat.images.present? ? @images = @subcat.images.pluck(:name) :  @images = ["/assets/club1.jpg","/assets/club2.jpg","/assets/club3.jpg","/assets/club1.jpg"]
		if @subcat.category.name=="Escort"
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

	def subcategories
		if params[:category_id].present? and params[:location].present? 
			begin
				@cat = Category.find_by_id(params[:category_id]) 
		  	# @subcat = @cat.subcategories.within(20, :origin => params[:location])
		  	@subcat = @cat.subcategories.where(:city=>params[:location].split(',')[0]).paginate(:page => params[:page], :per_page => params[:per_page])
				@result=[]
				@subcat.each do |s|
					@imgs = []
					if @cat.name=="Escort"
						s.images.each do |i|
							@imgs << "http://tecorb.com/admin/Max/cityvibe/cityvibe/#{i.name}"  
						end
					elsif @cat.name=="Massage parlour"
						for i in 0...5
							@imgs << "http://45.58.47.179/image/massageimgs/massage#{i}.jpg" 
						end
					else
						for i in 0...5
							@imgs << "http://45.58.47.179/image/stripclubimgs/club#{@cn}.jpg"
						end
					end
							
					@result << s.as_json(except: [:created_at,:updated_at,:profile_link,:page_url]).merge(:images=>@imgs) 
				end
				render :json => { :response_code => 200,:response_message => "successfully fetched",:subcategories=>@result }
			rescue Exception => e
				render :json => {:response_code => 200,:response_message=>"No isseue dud I'will take care this :) [ #{e} ]" }
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def find_subcategory
		if params[:subcategory_id].present?
			@subcategory = Subcategory.find_by_id(params[:subcategory_id])
			if @subcategory	
				@imgs = []
					if @subcategory.category.name=="Escort"
						@subcategory.images.each do |i|
							@imgs << "http://tecorb.com/admin/Max/cityvibe/cityvibe/#{i.name}"  
						end
					elsif @subcategory.category.name=="Massage parlour"
						for i in 0...5
							@imgs << "http://45.58.47.179/image/massageimgs/massage#{i}.jpg" 
						end
					else
						for i in 0...5
							@imgs << "http://45.58.47.179/image/stripclubimgs/club#{@cn}.jpg"
						end
					end
				render :json => { :response_code => 200, :response_message => "Sub category details",:subcategory=>@subcategory.as_json(except: [:created_at,:updated_at,:profile_link,:page_url]).merge(:images=>@imgs)}
			else
				render :json => { :response_code => 500, :response_message => "Sub category does not exists"}
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def update
  	@subcat=Subcategory.find_by_id(params[:id])
  	@subcat.update_attributes(:title=>params[:subcategory][:title],:description=>params[:subcategory][:description],:email=>params[:subcategory][:email],:contact=>params[:subcategory][:contact],:street_address=>params[:subcategory][:street_address],:city=>params[:subcategory][:city],:pin=>params[:subcategory][:pin],:state=>params[:subcategory][:state],:tag_line=>params[:subcategory][:tag_line],:category_id=>params[:category],:rating=>params[:subcategory][:rating])
  	redirect_to my_business_path(encrypt(current_business_user.id))
  end
end
