class AdressesController < ApplicationController
  def edit
  end
  def update
    @adress = current_user.adress
    if @adress.update(user_params)
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
