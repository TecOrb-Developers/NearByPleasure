class BookmarksController < ApplicationController

	def create_bookmark
		if params[:user_id].present?
			@user=User.find_by_id(params[:user_id])
			@subcat=Subcategory.find_by_id(params[:subcategory_id])
			if @user and @subcat
				 @bookmark=@user.bookmarks.create(:subcategory_id=>@subcat.id) if !@user.bookmarks.exists?(:subcategory_id=>@subcat.id)
				 render :json => { :response_code => 200, :response_message => "Successfully added to bookmark"  }#,:bookmark=>@bookmark.as_json(except: [:created_at,:updated_at]) 
			else
				render :json => { :response_code => 500, :response_message => "User or sub category does not exists"}
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def my_bookmarks
		if params[:user_id].present?
			@user = User.find_by_id(params[:user_id])
			if @user
				@bookmarks = @user.bookmarks.paginate(:page => params[:page], :per_page => params[:per_page])
				 render :json => { :response_code => 200, :response_message => "Successfully fetched" ,:bookmarks=>@bookmarks.as_json(except: [:created_at,:updated_at]) } 
			else
				render :json => { :response_code => 500, :response_message => "User does not exists"}
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def remove_bookmark
		@book=Bookmark.find_by_id(params[:bookmark_id])
		if @book
			@bookmrk=@book.destroy
		  render :json => { :response_code => 200, :response_message => "Removed from bookmark"}
	  else
	  	render :json => { :response_code => 500, :response_message => "Bookmark does not exist"}
	  end
	end

	def search_bookmark
		@user = User.find_by_id(params[:user_id])
		if @user
			@books=@user.bookmarks.pluck(:subcategory_id)
			p "=======#{@books}"
			@subcats = Subcategory.where("(id in (?)) and (city ILIKE (?))",@books,"#{params[:city].split(',')[0]}%").pluck(:id)
			p "=======#{@subcats}"
			@bookmarks = @user.bookmarks.where("subcategory_id in (?)",@subcats).paginate(:page => params[:page], :per_page => params[:per_page])
			render :json => { :response_code => 200, :response_message => "Successfully fetched" ,:bookmarks=>@bookmarks.as_json(except: [:created_at,:updated_at]) } 
		else
			render :json => { :response_code => 500, :response_message => "User does not exists"}
		end
	end
end
