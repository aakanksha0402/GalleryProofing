class AddBrandIdToInvoiceLineItems < ActiveRecord::Migration
  def change
    add_reference :invoice_line_items, :brand, index: true, foreign_key: true
  end
end
