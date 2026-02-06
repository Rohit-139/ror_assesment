class CartsController < ApplicationController
	def index
		@customer = Customer.find(session[:customer_id])
		@cart_items = @customer.cart.cart_items
	end

end
