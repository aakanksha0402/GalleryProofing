class CreateDiscountOfferTypes < ActiveRecord::Migration
  def change
    create_table :discount_offer_types do |t|
      t.references :discount_offer, index: true, foreign_key: true
      t.references :discount_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
