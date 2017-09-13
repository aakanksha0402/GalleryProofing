# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|

  config.mailer_sender = 'xyz@gmail.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..72
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  # config.scoped.views = true
  config.omniauth :facebook, "1004194373003354", "b6578d23e8668c082bd3fe8a7a7fc6fa",:scope => 'email,user_birthday,publish_actions'
  config.secret_key = '2fd7b5ac783cc985262092b90530d527041441e332559d962a74909fa1c6b2ce0be8d59d83e16b90cee6992d05b21db5cce0d89148d565aece159208c164c979'
end
