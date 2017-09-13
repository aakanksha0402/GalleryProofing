class CreateDiscountCartValues < ActiveRecord::Migration
  def change
    create_table :discount_cart_values do |t|
      t.references :discount, index: true, foreign_key: true
      t.decimal :from_value
      t.decimal :to_value
      t.decimal :percentage_value
      t.decimal :dollar_value

      t.timestamps null: false
    end
  end
end
