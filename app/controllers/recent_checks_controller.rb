class RecentChecksController < ApplicationController
	def recent_service
		@user=User.find_by_id(params[:user_id])
		if @user.present?
			@subcat=Subcategory.find_by_id(params[:subcategory_id])
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
			render :json => { :response_code => 500, :response_message => "User not exist!!"}
		end
	end
end
