class CreditsController < ApplicationController

  before_action :should_not_destroy_if_it_does_not_exist, only: :destroy

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
    credit = Credit.find(params[:id])
    if credit.destroy
      redirect_to credits_path
    else
      redirect_to credits_path, notice: "削除に失敗しました"
    end
  end

  private
  def credit_params
    params.require(:credit).permit(:card_number, :expiration_month, :expiration_year, :security_code).merge(user_id: current_user.id)
  end

  def should_not_destroy_if_it_does_not_exist
    redirect_to credits_path, notice: "no_content" unless Credit.exists?(id: params[:id])
  end
end
