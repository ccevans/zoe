class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end

  helper_method :current_user_subscribed?
  

  def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :role) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :role)}
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
