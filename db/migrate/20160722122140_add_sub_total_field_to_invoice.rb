class AddSubTotalFieldToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :sub_total, :integer
  end
end
