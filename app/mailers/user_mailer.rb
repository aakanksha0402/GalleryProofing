class UserMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def reset_password_instructions(user)
    @user = user
    mail(to: @user.email, subject: 'Password Reset Instructions')
  end
  
end
