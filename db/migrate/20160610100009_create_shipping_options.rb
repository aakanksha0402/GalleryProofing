class CreateShippingOptions < ActiveRecord::Migration
  def change
    create_table :shipping_options do |t|
      t.string :title
      t.string :price
      t.references :shipping, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
