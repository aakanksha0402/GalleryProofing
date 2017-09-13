class CreateDiscountBsgsBuyItems < ActiveRecord::Migration
  def change
    create_table :discount_bsgs_buy_items do |t|
      t.references :discount, index: true, foreign_key: true
      t.references :catalog, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
