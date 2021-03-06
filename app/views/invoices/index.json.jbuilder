json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :brand_id, :client_contact_id, :automation_series_id, :color_logo_id, :issue_date, :final_due_date, :sales_label, :sales_rate, :notes_to_client, :discount_type_id, :deposit_amount, :allow_payment_cash_cheque, :allow_payment_credit_card, :payment_confirmation_text
  json.url invoice_url(invoice, format: :json)
end
