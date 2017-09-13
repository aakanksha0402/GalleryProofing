class RemoveColumnsFromShipping < ActiveRecord::Migration
  def change
    remove_column :shippings, :shipping_option_price
    remove_column :shippings, :shipping_option_title
  end
end
