# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  def new2
    @user_adress = Adress.new
  end

  def create2
    Adress.create(
      user_id: current_user.id, 
      first_name: user_params[:first_name], 
      last_name: user_params[:last_name], 
      first_name_kana: user_params[:first_name_kana],
      last_name_kana: user_params[:last_name_kana],
      postal_code: user_params[:postal_code],
      prefecture: user_params[:prefecture],
      city: user_params[:city],
      street: user_params[:street],
      building_name: user_params[:building_name],
      tel: user_params[:tel]
      )

  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
    users_sign_up2_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  #   users_sign_up2_path
  # end
  private

  def user_params
    params.require(:adress)
  end
end
