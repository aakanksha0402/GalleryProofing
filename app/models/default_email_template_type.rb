class DefaultEmailTemplateType < ActiveRecord::Base
  has_many :default_email_templates, dependent: :destroy
  has_many :default_receipient_types, dependent: :destroy
  has_many :default_trigger_types, dependent: :destroy
end
