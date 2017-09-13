class AddFieldToCheckout < ActiveRecord::Migration
  def change
    add_column :checkouts, :paid, :boolean, default: false
    add_column :checkouts, :sales_tax, :decimal, default: 0.00
    add_column :checkouts, :sub_total, :decimal
  end
end
