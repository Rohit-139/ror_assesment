
class SignupController < ApplicationController
	skip_before_action :authorized, only: [:create, :index, :new_owner, :new_customer ,:login]
	include JsonWebToken
	def index 
	end

	def new_owner
		@owner = Owner.new
		render 'home_owner'
	end


	def new_customer
		@customer = Customer.new
		render 'home_customer'
	end

	def create
	  if params[:customer].present?
		  create_customer
		else
			create_owner
		end
	end
 
 def login
 end

 def login_customer
 	email = params[:signup] [:email]
 	password = params[:signup] [:password]
 	@customer = Customer.find_by(email: email)
 	if @customer&.authenticate(password)
 		# session[:customer_id] = @customer.id
 		@token = encode(user_id: @customer.id)
 		redirect_to customers_path
 	else 
 		render :login , status: :unprocessable_entity
 	end

 end

	private 

	def create_customer 
		@customer = Customer.new(customer_params)
		if @customer.save!
			 @token = encode(user_id: @customer.id)
			redirect_to login_path
		else
			flash.now[:alert] = @customer.errors.full_messages.to_sentence
			render :home_customer , status: :unprocessable_entity
		end
	end


	def create_owner 
		@owner = Owner.new(owner_params)
		if @owner.save!
			session[:owner_id] = @owner.id
			redirect_to new_restaurant_path
		else
			render :home_customer , status: :unprocessable_entity
		end
	end

	def customer_params
		params.require(:customer).permit(:name,:password,:email,:password_confirmation)
	end

	def owner_params
		params.require(:owner).permit(:name,:password,:email,:password_confirmation)
	end


end
