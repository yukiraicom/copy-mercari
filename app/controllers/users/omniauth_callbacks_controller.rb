# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback("facebook")
  end

  def google_oauth2
    callback("google")
  end

  def after_sign_in_path_for(resource) #sign_in_and_redirectで呼び出される。
    if current_user.adress.nil?
      users_sign_up2_path 
    else
      super(resource)
    end
  end

  def callback(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provier}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

