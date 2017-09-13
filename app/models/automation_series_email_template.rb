class AutomationSeriesEmailTemplate < ActiveRecord::Base
  #associations
  belongs_to :automation_series
  belongs_to :email_template
  belongs_to :default_receipient_type
  belongs_to :default_trigger_type

  #validations
  validates :email_template_id, presence: { message: "Email Template can't be Blank" }
  validates :default_receipient_type_id, presence: { message: "Receipient Type can't be Blank" }
  validates :default_trigger_type_id, presence: { message: "Trigger Type can't be Blank" }
  validates :trigger_days, presence: { message: "Trigger Days can't be Blank" }
  validates :template_name, presence: { message: "Template Name can't be Blank" }
end
