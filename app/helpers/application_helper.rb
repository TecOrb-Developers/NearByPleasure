module ApplicationHelper
	include Preventurl
	require 'net/http'
	require 'uri'
	require 'json'
    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end
    
	def categories
		Category.all
	end
	def google_api_key
	 key="AIzaSyCJaA4u0M0Az0aGc73Gjei7seHBKy7XxTk"
	end

	def ip_infodb_key
		key="059eb8577353df53b23e191f510774579d48f7b84b833a34c4f06b26588a8145"
	end

	def ip_location ip 
		ipaddress = Ip.find_by_ip(ip)	
		if ipaddress.present?
			ipaddress
		else	
			uri = URI("http://api.ipinfodb.com/v3/ip-city/?key=#{ip_infodb_key}&ip=#{ip}")
			resp = Net::HTTP.get_response(uri)
	  	# hash = JSON(resp.body)
	  	p "-----#{resp.body}"
	  	resp
	  end
	end

	def all_cities
		Subcategory.all.pluck(:city).uniq
	end

	def lat_lng address
		sleep 1
		add=address.gsub(' ','+')
		uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{add}&key=#{google_api_key}")
		resp = Net::HTTP.get_response(uri)
	  hash = JSON(resp.body)
	  # p "---#{hash['results'].first['geometry']['location']['lat']}--#{hash['results'].first['geometry']['location']['lng']}"
	  
	  if hash['results'].present?
  		if hash['results'].first.present?
				if hash['results'].first['geometry'].present?
					if hash['results'].first['geometry']['location'].present?
						if hash['results'].first['geometry']['location']['lat'].present?
							res=[hash['results'].first['geometry']['location']['lat'],hash['results'].first['geometry']['location']['lng']]
						else
							p"==========hash['results'].first['geometry']['location']=====#{hash['results'].first['geometry']['location'].inspect}"
						end
					else
						p "==============hash['results'].first['geometry']-----#{hash['results'].first['geometry']['location'].inspect}"
					end
				else
					p "===========hash['results'].first-----#{hash['results'].first.inspect}-------"
				end
			else
				p "=========hash['results']-----#{hash['results'].inspect}"
			end
		else
			p "=========results not present====="
		end
	end

	def all_massage_image
		["/assets/massage1.jpg","/assets/massage2.jpg","/assets/massage3.jpg","/assets/massage4.jpg","/assets/massage5.jpg","/assets/massage0.jpg"]
	end
	def massage_image num
		# ["massage1.jpg","massage2.jpeg","massage3.jpg","massage4.jpg","massage5.jpg","massage0.jpg"].sample
		"massage#{num}.jpg"
	end

	def require_logged_in
		unless logged_in?
			flash[:notice]="you need to require log in"
			redirect_to payment_path
		end
	end

	def logged_in?
		current_business_user
	end

    def current_business_user
		@current_business_user ||= User.find(session[:business_id]) if (session[:business_id])
	end

	def current_business_user
		@current_business_user ||= User.find(session[:business_id]) if (session[:business_id])
	end
end
