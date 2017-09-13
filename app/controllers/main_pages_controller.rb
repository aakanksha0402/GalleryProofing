class MainPagesController < ApplicationController
  def home
    @user = current_user
  end
  def profile
  end
  def new
  end
  def update
    @user=User.find(current_user.id)
    if @user.update!(user_params)
        flash[:success] = "Profile successfully updated!!"
        redirect_to '/'
      else
        render 'edit'
      end
  end

  def no_authorization

  end

  private
  def user_params
    params.require(:user).permit(:firstname,:lastname)
  end
end
