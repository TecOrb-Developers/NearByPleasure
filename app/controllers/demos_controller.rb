class DemosController < ApplicationController
	def new 
		render :layout =>"empty"
	end
	def home
		render :layout => "empty"
	end
end
