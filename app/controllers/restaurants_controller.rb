class RestaurantsController < ApplicationController

	before_action :set_restaurant, only: %i[ show edit update destroy ]

	def new 
		@restaurant = Restaurant.new
	end

	def index
		@owner = Owner.find(session[:owner_id])
		@restaurants = Restaurant.where(owner_id: session[:owner_id])
	end

	def create
		@owner = Owner.find(session[:owner_id])
		@restaurant = @owner.restaurants.new(restaurant_params)

		if @restaurant.save 
			redirect_to restaurants_path
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def destroy
		@restaurant.destroy
		redirect_to restaurants_path
	end

	def update
		
		if @restaurant.update(restaurant_params)
			redirect_to restaurants_path
		else 
			render :edit, status: :unprocessable_entity
		end
	end

	def show
		@dishes = @restaurant.dishes
	end

  private

	def restaurant_params
		params.require(:restaurant).permit(:name,:description)
	end

	def set_restaurant
		@restaurant = Restaurant.find(params[:id])
	end
end
