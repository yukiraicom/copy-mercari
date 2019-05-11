class UsersController < ApplicationController
  def show
  end
  def edit
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
