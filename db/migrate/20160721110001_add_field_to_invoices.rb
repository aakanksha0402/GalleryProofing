class AddFieldToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :grand_total, :decimal
    add_column :invoices, :deposit, :decimal,default: 0
  end
end
