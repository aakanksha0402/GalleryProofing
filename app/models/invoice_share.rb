class InvoiceShare < ActiveRecord::Base
  belongs_to :email_template
  belongs_to :invoice
end
