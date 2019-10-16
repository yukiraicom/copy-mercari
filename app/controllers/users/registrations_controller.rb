
class Users::RegistrationsController < Devise::RegistrationsController
  
  def new
    super
  end

  def adress
    @user_adress = Adress.new
  end

  def adress_create
    @user_adress = Adress.new(
      user_id: current_user.id, 
      first_name: user_params[:first_name], 
      last_name: user_params[:last_name], 
      first_name_kana: user_params[:first_name_kana],
      last_name_kana: user_params[:last_name_kana],
      birthday: birthday_params,
      postal_code: user_params[:postal_code],
      prefecture: user_params[:prefecture],
      city: user_params[:city],
      street: user_params[:street],
      building_name: user_params[:building_name],
      tel: user_params[:tel]
      )
    if @user_adress.save
      redirect_to users_sign_up3_path
    else
      @user_adress
      render :adress
    end
  end

  def credit
    @credit = Credit.new
  end

  def credit_create
    @credit = Credit.new(credit_params)
    if @credit.save
      begin
        token = Payjp::Token.create({
          :card => {
            :number => @credit.card_number,
            :cvc => @credit.security_code,
            :exp_month => @credit.expiration_month,
            :exp_year => 2000 + @credit.expiration_year
          }},
          {
            'X-Payjp-Direct-Token-Generate': 'true'
          } 
        ) #トークン作成 
      rescue => e
        @errors = e
        @credit.delete
        render :credit
        return false
      end
      customer = Payjp::Customer.create(
        description: 'test',
        card: token.id
      )
      @credit.update(pay_id: token.id, customer_id: customer.id)
      redirect_to users_sign_up_fin_path
    else
      @credit
      render :credit
    end
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

  def birthday_params
    begin
      Date.new(params.require(:adress)[:"birthday(1i)"].to_i,
              params.require(:adress)[:"birthday(2i)"].to_i,
              params.require(:adress)[:"birthday(3i)"].to_i)
    rescue
      return nil
    end
  end
  
  def credit_params
    params.require(:credit).permit(:card_number, :expiration_month, :expiration_year, :security_code).merge(user_id: current_user.id)
  end

end
