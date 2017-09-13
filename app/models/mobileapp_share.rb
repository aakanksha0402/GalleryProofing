class MobileappShare < ActiveRecord::Base
  belongs_to :email_template
  belongs_to :mobileapp
end
