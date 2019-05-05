class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Add parameters for User beyond those provided by Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :location, :age])

    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :location, :age])
  end

  private

  # Change the path after sign out to something other than root
  def after_sign_out_path_for(resource_or_scope)
    login_path
  end

end
