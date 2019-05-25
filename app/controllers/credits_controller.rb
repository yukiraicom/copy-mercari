class CreditsController < ApplicationController
  def index
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

  private
  def credit_params
    params.require(:credit).permit(:card_number, :expiration_month, :expiration_year, :security_code).merge(user_id: current_user.id)
  end
end
