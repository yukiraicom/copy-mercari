class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:index]


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_kanai])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:postal_code])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:prefecture])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:city])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:street])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:building_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:tel])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:card_number])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:expiration_month])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:expiration_year])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:security_coder])
  end
end
