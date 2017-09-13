class AddFieldsToDiscount < ActiveRecord::Migration
  def change
    add_reference :discounts, :pricing, index: true, foreign_key: true
    add_reference :discounts, :discount_offer_type, index: true, foreign_key: true
    add_column :discounts, :name, :string
    add_column :discounts, :promocode, :string
    add_column :discounts, :use_limit, :integer
    add_column :discounts, :expiration_date, :date
    add_column :discounts, :quantity, :integer
    add_column :discounts, :checkout_limit, :integer
    add_column :discounts, :checkout_used, :integer
    add_column :discounts, :is_automatic, :boolean
  end
end
