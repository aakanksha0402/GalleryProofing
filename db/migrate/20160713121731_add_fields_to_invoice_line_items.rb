class AddFieldsToInvoiceLineItems < ActiveRecord::Migration
  def change
    add_column :invoice_line_items, :name, :string
    add_column :invoice_line_items, :description, :text
    add_column :invoice_line_items, :quantity, :integer
    add_column :invoice_line_items, :price, :decimal
    add_column :invoice_line_items, :is_taxable, :boolean,default: false
  end
end
