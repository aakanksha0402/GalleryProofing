class RenameTotalPriceInCheckout < ActiveRecord::Migration
  def change
    rename_column :checkouts, :total_price, :amount
  end
end
