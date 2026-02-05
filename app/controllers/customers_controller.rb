class CustomersController < ApplicationController
	def index
		@restaurants = Restaurant.all
	end

	def dishes
		@restaurant = Restaurant.find(params[:restaurant_id])
		@dishes = @restaurant.dishes
	end
end
