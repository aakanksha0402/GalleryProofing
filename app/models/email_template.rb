class EmailTemplate < ActiveRecord::Base
  belongs_to :default_email_template
  belongs_to :brand
  has_many :automation_series_email_templates, dependent: :destroy
  has_many :automation_series, through: :automation_series_email_templates
  has_many :gallery_shares, dependent: :destroy
  has_many :invoice_emails, dependent: :destroy
  has_many :mobileapp_shares,dependent: :destroy
  has_many :invoice_shares, dependent: :destroy

  validates :name, presence: true
  validates :email_subject, presence: true
  validates :email_body, presence: true
  validates :headline, presence: true
  validates :button_text, presence: true
end
