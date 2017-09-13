class InvoiceEmail < ActiveRecord::Base
  belongs_to :email_template
  belongs_to :invoice

  def email_address
    email_id
  end

  scope :email, lambda{|email| where('email_id ILIKE ? ', "%#{email}%" )}
end
