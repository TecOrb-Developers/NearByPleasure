class HomeController < ApplicationController
  def index
    @cat=Category.all
  	@cat1 = Category.find_by_name("Escort")
    p"-----#{@cat1}"
  	@cat2 = Category.find_by_name("Massage parlour")
    @cat3 = Category.find_by_name("Strip Club")
  	@escorts = @cat1.subcategories.first(6)
  	@rubmaps = @cat2.subcategories.first(4)
    @strip_clubs=@cat3.subcategories.first(3)
    # request.remote_ip
    # @remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    # p "**********************#{request.remote_ip}"
    # ip_location("45.58.47.179")
    render :layout=>"home_application"
  end
  def new
  	@cat1 = Category.find_by_name("Escort")
	  @escorts = @cat1.subcategories.limit(24)
    render :layout=>"home_application"
  end
  def details
  	@cat1 = Category.find_by_name("escort")
  	@escort = @cat1.subcategories.sample(1).first
  	@images = @escort.images.pluck(:name)
    render :layout=>"home_application"
  end
end

