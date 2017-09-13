class RenameFieldInShipping < ActiveRecord::Migration
  def change
    rename_column :shippings, :shipping_optio_price, :shipping_option_price
  end
end
