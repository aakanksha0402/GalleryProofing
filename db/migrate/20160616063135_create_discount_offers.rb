class CreateDiscountOffers < ActiveRecord::Migration
  def change
    create_table :discount_offers do |t|
      t.string :offer
      t.string :value

      t.timestamps null: false
    end
  end
end
