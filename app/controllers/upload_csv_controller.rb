class UploadCsvController < ApplicationController
	require 'csv'
  def index
  end
  def create
    file=params[:category][:file]
    @i=1
		@status=false
    if File.extname(file.original_filename)=='.csv'
      CSV.foreach(file.path) do |row|
	      if @i==1
			  	p "-------------------#{row.inspect}"
				   #row[0] == "link" and row[1] == "title" and row[2] == "contact" and row[3] == "description" and row[5]=="image_urls"
					if row[0]=="page_link" and row[1]=="profile_link" and row[2]=="title" and row[3]=="tag_line" and row[4]=="contact" and row[5]=="email" and row[6]=="latitude" and row[7]=="longitude" and row[8]=="state" and row[9]=="city" and row[10]=="description" and row[11]=="images_name" and row[12]=="images_url"
            @cat = "escort"
					  @status = true
				  elsif row[0]== "page_url" and row[1]== "profile_url" and row[2]== "title" and row[3]== "contact" and row[4]== "timing" and row[5]== "street_address" and row[6]== "city" and row[7]== "state" and row[8]== "pin" and row[9]== "images" and row[10]== "description" 
						@cat = "rubmap"
						@status = true             
					elsif row[0]=="page_url" and row[1]=="profile_link" and row[2]=="title" and row[3]=="contact" and row[4]=="rating" and row[5]=="reviews" and row[6]=="street_address" and row[7]=="city" and row[8]=="state" and row[9]=="pin" and row[10]=="description" 
            @cat = "Strip Club"
            @status = true 
          else
						@status = false
						break
				  end
				else
	      	@category= Category.find_by_name(@cat)
	      	if !@category
	      		@category=Category.create!(:name=>@cat)
	      	end        
	      	@subcat={}
	      	if @cat=="escort"
	       		@subcat={title: row[2],contact:  row[4],description: row[9],tag_line: row[3],profile_link: row[1],latitude: row[6],longitude: row[7],email: row[5],timing: nil,street_address: nil,city: row[8],pin: nil,state: nil,page_url: nil}
	       	elsif @cat=="rubmap"              
	       		@subcat={title: row[2],profile_link: row[1],contact: row[3],description: row[10],timing: row[4],street_address: row[5],city: row[6],pin: row[8],state: row[7],page_url: row[0]}
          elsif @cat = "Strip Club"
            @subcat={title: row[2],profile_link: row[1],contact: row[3],description: row[10],street_address: row[6],city: row[7],pin: row[9],state: row[8],page_url: row[0],reviews: row[5].present? ? row[5].split(' ')[0] : nil,rating: row[4].present? ? row[4].split(' ')[1] : nil,timing: nil}
	       	end
	         (@cat=="rubmap" or @cat=="Strip Club") ? @subcategory=@category.subcategories.find_by_profile_link(row[1]) : @subcategory=@category.subcategories.find_by_title(row[1].strip)
       		p "-------------------#{@subcat}"
       		if !@subcategory
       			@subcategory= @category.subcategories.create!(@subcat) if  row[2].present?
       		else
       			# @subcategory.update_attributes(@subcat)
       		end
       		if @cat == "escort"
       			row[11].present? ? @images=row[11].split(',') : @images=[]
       		elsif @cat== "rubmap"
       			row[9].present? ? @images=row[9].split(',') : @images=[]
       		end
          if  row[2].present?
         		if @images.present?
         			@images.each do |img|
         				if !@subcategory.images.exists?(:name=>img)
         					@subcategory.images.create(:name=>img,:category_id=>@category.id)
         				end
         			end
         		end
          end
		    end
        @i+=1
      end
      @status ? flash[:notice] = "all #{@cat}s  of this file has been imported successfully" :  flash[:error]="Not a valid file"
			redirect_to :back
    else
      flash[:error]="Not a csv file"
      redirect_to :back
    end 
  end
end
