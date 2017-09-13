class AddValueFieldToDiscount < ActiveRecord::Migration
  def change
    add_column :discounts, :value, :decimal
  end
end
