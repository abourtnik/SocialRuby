class RegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:username, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :current_password , :avatar, :avatar_cache, :remove_avatar)}
  end

end