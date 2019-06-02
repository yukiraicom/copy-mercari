class CreditsController < ApplicationController
  def index
    if current_user.credit.present?
      @credit_last_num = /\d{4}$/.match(current_user.credit.card_number.to_s)[0]
      @expiration_date = "#{current_user.credit.expiration_month}" + "/" + "#{current_user.credit.expiration_year}"
    end
  end
  def new
    @credit = Credit.new
  end
  def create
    credit = Credit.new(credit_params)
    if credit.save
      redirect_to credits_path
    else
      @credit_error = credit.errors.full_messages
      render :new
    end
  end
  def destroy
  Credit.find(params[:id]).destroy
  redirect_to credits_path
  end

  private
  def credit_params
    params.require(:credit).permit(:card_number, :expiration_month, :expiration_year, :security_code).merge(user_id: current_user.id)
  end
end
