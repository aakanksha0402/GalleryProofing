class AddDisplayOrderFieldToInvoiceLineItem < ActiveRecord::Migration
  def change
    add_column :invoice_line_items, :display_order, :integer
  end
end
