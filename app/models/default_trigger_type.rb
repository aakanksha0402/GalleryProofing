class DefaultTriggerType < ActiveRecord::Base
  has_many :email_automation_series, dependent: :destroy
  belongs_to :default_email_template_type
end
