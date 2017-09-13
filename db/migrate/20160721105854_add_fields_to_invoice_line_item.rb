class AddFieldsToInvoiceLineItem < ActiveRecord::Migration
  def change
    add_column :invoice_line_items, :total_price, :decimal
    add_column :invoice_line_items, :tax, :decimal, default: 0
  end
end
