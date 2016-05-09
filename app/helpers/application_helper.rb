module ApplicationHelper

	def categories
		Category.all
	end
	def google_api_key
	 key="AIzaSyCJaA4u0M0Az0aGc73Gjei7seHBKy7XxTk"
	end

	def all_cities
		Subcategory.all.pluck(:city).uniq
	end
end
