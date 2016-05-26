class RecentChecksController < ApplicationController
	def recent_service
		if params[:subcategory_id].present? and params[:user_id].present?
			@user=User.find_by_id(params[:user_id])
			if @user
				@subcat=Subcategory.find_by_id(params[:subcategory_id])
				if @subcat
					if @user.recent_checks.count < 3
						@recentchk=RecentCheck.create(:user_id=>@user.id,:subcategory_id=>@subcat.id)
						render :json => { :response_code => 200, :response_message => "Recens are!!",:recent=>@recentchk.as_json(except: [:created_at,:updated_at]) }
					else
					 @recent=RecentCheck.order(created_at:"ASC")
					 RecentCheck.destroy(@recent.first)
					 @recentchk=RecentCheck.create(:user_id=>@user.id,:subcategory_id=>@subcat.id)
					 render :json => { :response_code => 200, :response_message => "Recens are!!",:recent=>@recentchk.as_json(except: [:created_at,:updated_at]) }
					end
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
end
