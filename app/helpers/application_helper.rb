module ApplicationHelper
require 'net/http'
require 'uri'
require 'json'
	def categories
		Category.all
	end
	def google_api_key
	 key="AIzaSyCJaA4u0M0Az0aGc73Gjei7seHBKy7XxTk"
	end

	def all_cities
		Subcategory.all.pluck(:city).uniq
	end

	def lat_lng address
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
end
