class UsersController < ApplicationController
  def show
    @user = current_user
  end
  def edit
    @user = current_user
  end
  def update
    User.find(params[:id]).update(update_user)
    redirect_to action: "edit"
  end

  private
  def update_user
    params.require(:user).permit(:nickname, :profile)
  end
end
