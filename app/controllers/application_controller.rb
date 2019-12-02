class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,  keys: [:name,:school_id, :adviser, :admin])
  end 

  def header_menu
    if user_signed_in?
      @coming_chats = current_user.chats.incoming.order(start_at: :asc)
    else
    end
  end
end
