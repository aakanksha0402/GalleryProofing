class AutomationSeries < ActiveRecord::Base
  belongs_to :brand
  has_many :automation_series_email_templates, dependent: :destroy
  has_many :email_templates, through: :automation_series_email_templates
  has_many :invoices, dependent: :destroy

  validates :name, presence: true

  def text_value
    name
  end
  def text
    "AutomationSeries"
  end
end
