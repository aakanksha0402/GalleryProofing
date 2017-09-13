class Invoice < ActiveRecord::Base
  belongs_to :brand
  belongs_to :client_contact
  belongs_to :automation_series
  belongs_to :color_logo
  belongs_to :discount_type
  has_many :invoice_line_items,dependent: :destroy
  has_many :invoice_emails,dependent: :destroy
  has_many :add_payments,dependent: :destroy
  has_many :invoice_shares, dependent: :destroy

  accepts_nested_attributes_for :invoice_line_items


  scope :client_name_email, lambda { |c_name_email| joins("LEFT JOIN client_contacts on invoices.client_contact_id = client_contacts.id").where("client_contacts.firstname LIKE ? OR client_contacts.email LIKE ?", "%#{c_name_email}%","%#{c_name_email}%")}
  scope :item_name_description, lambda { |item_name_desc| joins("LEFT JOIN invoice_line_items on invoices.id = invoice_line_items.invoice_id").where("invoice_line_items.name = ? OR invoice_line_items.description = ? ", "%#{item_name_desc}%", "%#{item_name_desc}%") }
  scope :invoice_number, lambda { |invoice_num| where("invoices.id::varchar LIKE ? ", "%#{invoice_num}%") }
  scope :invoice_status, lambda { |status_id| where("invoices.status_id::varchar LIKE ? ", "%#{status_id}%")  }


  def remaining_balance
    cash_amount_pay = self.add_payments.where(payment_with_id: 1).sum(:amount)
    credit_amount_pay = self.add_payments.where(payment_with_id: 2 , success: true).sum(:amount)
    return self.grand_total - (cash_amount_pay + credit_amount_pay)
  end


end
