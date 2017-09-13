class InvoiceShareMailer < ApplicationMailer

  def send_invoice(invoice)
    @invoice_mail = invoice
    @invoice = Invoice.find(@invoice_mail.invoice_id)
    @current_brand_name = Brand.find(@invoice.brand_id).brand_name
    @buttontext = @invoice_mail.buttontext
    mail(to: @invoice_mail.recipient, subject: "An Invoice from #{@current_brand_name}" )
  end
  
end
