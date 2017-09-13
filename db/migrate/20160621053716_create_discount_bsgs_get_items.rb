class CreateDiscountBsgsGetItems < ActiveRecord::Migration
  def change
    create_table :discount_bsgs_get_items do |t|
      t.references :discount, index: true, foreign_key: true
      t.references :catalog, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
