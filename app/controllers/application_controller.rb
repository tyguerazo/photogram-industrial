class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :private, :name, :bio, :website, :avatar_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :private, :name, :bio, :website, :avatar_image])
  end
end
