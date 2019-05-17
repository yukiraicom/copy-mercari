class AdressesController < ApplicationController
  def edit
    @adress = current_user.adress
  end
  def update
    @adress = current_user.adress
    if @adress.update(
        postal_code: user_params[:postal_code],
        prefecture: user_params[:prefecture],
        city: user_params[:city],
        street: user_params[:street],
        building_name: user_params[:building_name],
        )
      redirect_to action: "edit"
    else
      @adress_error = @adress.errors.full_messages
      render :edit
    end
  end

  private
  def user_params
    params.require(:adress)
  end
end
