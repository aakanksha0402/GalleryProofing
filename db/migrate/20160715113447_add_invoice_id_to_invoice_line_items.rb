class AddInvoiceIdToInvoiceLineItems < ActiveRecord::Migration
  def change
    add_reference :invoice_line_items, :invoice, index: true, foreign_key: true
  end
end
