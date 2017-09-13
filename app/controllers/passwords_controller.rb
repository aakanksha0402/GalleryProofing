class PasswordsController < Devise::PasswordsController
  def after_sending_reset_password_instructions_path_for(resource_name)
    # main_pages_reset_password_path
     new_user_session_path
  end
end
