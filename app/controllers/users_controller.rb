class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update_profile
    @user = User.find(current_user.id)
    if @user.update_without_password(user_params)
      @updated = true
      puts @user.errors.as_json
      session.delete(:modal)
    else
      @updated = false
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email)
  end
end
