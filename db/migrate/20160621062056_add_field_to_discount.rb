class AddFieldToDiscount < ActiveRecord::Migration
  def change
    add_column :discounts, :bogo_qty, :integer
  end
end
