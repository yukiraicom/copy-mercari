class UsersController < ApplicationController
  def show
  end
  def edit
  end
  def update
    @user = User.find(params[:id])
    if @user.update(update_user)
      redirect_to action: "edit"
    else
      @user_error = @user.errors.full_messages
      render :edit
    end
  end

  def logout
  end

  private
  def update_user
    params.require(:user).permit(:nickname, :profile)
  end
end
