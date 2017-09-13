class AddIsDeletedFieldToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :is_deleted, :boolean, default: false
  end
end
