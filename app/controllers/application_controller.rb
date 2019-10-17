class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?
  require 'payjp'
  Payjp::api_key = ENV['testPayjpKey']

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, 
      keys: [
        :nickname, 
        :profile, 
        :first_name, 
        :last_name, 
        :first_name_kanai,
        :last_name_kana,
        :postal_code,
        :prefecture,
        :city,
        :street,
        :building_name,
        :tel,
        :card_number,
        :expiration_month,
        :expiration_year,
        :security_coder
      ]
    )
  end
  
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
