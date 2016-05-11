class HomeController < ApplicationController
  def index
    @cat=Category.all
  	@cat1 = Category.find_by_name("escort")
  	@cat2 = Category.find_by_name("Massage Parler")
    @cat3 = Category.find_by_name("Strip Club")
  	@escorts = @cat1.subcategories.sample(6)
  	@rubmaps = @cat2.subcategories.sample(4)
    @strip_clubs=@cat3.subcategories.sample(3)
    request.remote_ip
    @remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    p "**********************#{request.remote_ip}"
    # ip_location("45.58.47.179")
  end
  def new
  	@cat1 = Category.find_by_name("escort")
	  @escorts = @cat1.subcategories.sample(24)
  end
  def details
  	@cat1 = Category.find_by_name("escort")
  	@escort = @cat1.subcategories.sample(1).first
  	@images = @escort.images.pluck(:name)
  end
end
