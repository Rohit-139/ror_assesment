class ApplicationController < ActionController::Base

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # before_action :authorized

  

  def current_user
    decoded = decode(token)
    user_id = decoded[0]['user_id']
    @customer = Customer.find(user_id)
  end

   def authorized
    byebug
     unless !!current_user
       render json: { message: 'Please log in' }, status: :unauthorized
     end
   end

end
