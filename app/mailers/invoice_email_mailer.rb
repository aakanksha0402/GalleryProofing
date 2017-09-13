class InvoiceEmailMailer < ApplicationMailer

  def invoice_email_mailer(recipient,current_brand)
    @invoice_email = recipient
    @buttontext = recipient.button_text
    @subject = recipient.subject
    @current_brand=current_brand
    mail(to: @invoice_email.email_id,subject: @invoice_email.subject)
  end
end
