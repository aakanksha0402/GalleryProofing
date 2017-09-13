class AddFieldsToInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :discount_type_id
    add_reference :invoices, :deposit_type, index: true
    add_reference :invoices, :status, index: true, default: 1
  end
end
