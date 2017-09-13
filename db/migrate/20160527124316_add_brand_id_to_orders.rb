class AddBrandIdToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :brand, index: true, foreign_key: true
  end
end
