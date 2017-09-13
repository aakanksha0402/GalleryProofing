class DefaultEmailTemplate < ActiveRecord::Base
  has_many :email_templates, dependent: :destroy
  belongs_to :default_email_template_type

  def text_value
    email_type
  end

  def text
    "DefaultEmailTemplate"
  end

  default_scope { order("id ASC") }

end
