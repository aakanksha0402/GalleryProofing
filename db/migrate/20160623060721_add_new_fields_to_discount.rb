class AddNewFieldsToDiscount < ActiveRecord::Migration
  def change
    add_column :discounts, :package_price, :decimal
    add_column :discounts, :package_shipping, :decimal
  end
end
