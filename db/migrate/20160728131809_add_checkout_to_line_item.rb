class AddCheckoutToLineItem < ActiveRecord::Migration
  def change
    remove_column :line_items, :checkout_id, :integer
    add_reference :line_items, :checkout, index: true, foreign_key: true
  end
end
