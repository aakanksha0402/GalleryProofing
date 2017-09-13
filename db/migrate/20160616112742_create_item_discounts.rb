class CreateItemDiscounts < ActiveRecord::Migration
  def change
    create_table :item_discounts do |t|
      t.references :discount_offer_type, index: true, foreign_key: true
      t.decimal :value
      t.string :promocode
      t.integer :use_limit
      t.date :expiration_date
      t.integer :quantity
      t.integer :checkout_limit
      t.integer :checkout_used
      t.boolean :is_automatic
      t.references :pricing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
