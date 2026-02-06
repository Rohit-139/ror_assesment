class CustomersController < ApplicationController
	def index
		@restaurants = Restaurant.all
	end

	def dishes
		@restaurant = Restaurant.find(params[:id])
		@dishes = @restaurant.dishes
	end

	def add
		puts "update is called"

	end
end
