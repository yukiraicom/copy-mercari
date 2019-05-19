class AdressesController < ApplicationController
  def edit
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
      redirect_to edit_adress_path
    else
      @adress_error = @adress.errors.full_messages
      render :edit
    end
  end

  private
  def user_params
    params.require(:adress).permit(:postal_code, :prefecture, :city, :street, :building_name)
  end
end
