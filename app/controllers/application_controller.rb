class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    # if current_user && current_user.admin?
    #   redirect_to admin_root_url, :alert => exception.message
    # else
    #   redirect_to root_url, :alert => exception.message
    # end
  end
end
