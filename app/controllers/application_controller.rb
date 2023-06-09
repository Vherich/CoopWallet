class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def configure_permitted_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name) }
    devise_parameter_sanitizer.for(:edit) { |u| u.permit(:email, :password, :password_confirmation, :name) }
  end
end
