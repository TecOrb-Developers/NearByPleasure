class RecentChecksController < ApplicationController

	def recent_service
		if params[:subcategory_id].present? and params[:user_id].present?
			@user=User.find_by_id(params[:user_id])
			if @user
				@subcat=Subcategory.find_by_id(params[:subcategory_id])
				if @subcat
					if @user.recent_checks.count < 20
						if !@user.recent_checks.exists?(:subcategory_id=>@subcat.id)
							@recentchk=RecentCheck.create(:user_id=>@user.id,:subcategory_id=>@subcat.id)
						else
							@recentchk=@user.recent_checks.where(:subcategory_id=>@subcat.id).first
						end
					else
					 @recent=RecentCheck.order(created_at:"ASC")
					 @recent.first.destroy
					 @recentchk=RecentCheck.create(:user_id=>@user.id,:subcategory_id=>@subcat.id)
					end
					render :json => { :response_code => 200, :response_message => "Added to recent check",:recent=>@recentchk.as_json(except: [:created_at,:updated_at]) }
				else
					render :json => { :response_code => 500, :response_message => "Sub category does not exists!!"}
				end
			else
				render :json => { :response_code => 500, :response_message => "User not exists!!"}
			end
		else
			render :json => { :response_code => 500,:response_message => "Please provide all required parameters" }
		end
	end

	def all_recent
		@recents=RecentCheck.all.order(created_at:"DESC").paginate(:page => params[:page], :per_page => params[:per_page])
		render :json => { :response_code => 200, :response_message => "Recens are!!",:recent=>@recents.as_json(except: [:created_at,:updated_at]) }
	end 
end
