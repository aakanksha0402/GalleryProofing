class AddBuyQtyFieldToDiscount < ActiveRecord::Migration
  def change
    add_column :discounts, :bogo_buy_qty, :integer
    rename_column :discounts, :bogo_qty, :bogo_get_qty
  end
end
