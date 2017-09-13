json.array!(@invoice_line_items) do |invoice_line_item|
  json.extract! invoice_line_item, :id
  json.url invoice_line_item_url(invoice_line_item, format: :json)
end
