
class Users::RegistrationsController < Devise::RegistrationsController
  
  def new
    super
  end

  def adress
    @user_adress = Adress.new
  end

  def adress_create
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
    redirect_to users_sign_up3_path
  end

  def credit
    @credit = Credit.new
  end

  def credit_create
    Credit.create(
      user_id: current_user.id,
      card_number: credit_params[:card_number].to_i,
      expiration_month: credit_params[:expiration_month].to_i,
      expiration_year: credit_params[:expiration_year].to_i,
      security_code: credit_params[:security_code].to_i
    )
    redirect_to users_sign_up_fin_path
  end

  def fin
  end

  def create
    super
  end

  
  def after_sign_up_path_for(resource)
    super(resource)
    users_sign_up2_path
  end

  private

  def user_params
    params.require(:adress)
  end
  
  def credit_params
    params.require(:credit)
  end
end
