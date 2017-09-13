module InvoicesHelper

  def invoice_deposit_required(invoice)
    amount = ""
    if invoice.deposit_type_id.present?
      amount = invoice.deposit_type_id == 2 ? invoice.deposit_amount : (invoice.deposit_amount * (invoice.grand_total/ 100))
    else
      amount = 0.00
    end
    amount
  end
end
