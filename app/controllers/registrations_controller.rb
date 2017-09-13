class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  private
  def sign_up_params
    params.require(resource_name).permit( :email, :password, :password_confirmation, :studio_name, :country_id, :firstname, :lastname, :sub_user).merge(role: true)
  end

  def after_sign_up_path_for(resource)
    session[:user_id] = resource.id
    session[:modal] = true
    root_path
  end
end
