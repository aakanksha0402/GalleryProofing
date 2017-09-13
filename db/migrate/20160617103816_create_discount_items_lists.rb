class CreateDiscountItemsLists < ActiveRecord::Migration
  def change
    create_table :discount_items_lists do |t|
      t.integer :catalog_id
      t.boolean :active
      t.references :discount, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
