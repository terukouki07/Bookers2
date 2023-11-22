class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    about_path
    # flash[:notice] = "Welcome! You have signed up successfully."
    super
  end

  def after_sign_out_path_for(resource)
    root_path
  #   flash[:notice] = "Signed out successfully."
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
  end
end
