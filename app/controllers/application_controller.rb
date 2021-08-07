class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def ensure_admin
    return true if user_signed_in? && current_user.admin?

    redirect_to root_path, flash: {alert: "You don't have enough permissions to proceed"}
    false
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :name)
    end
  end

end
