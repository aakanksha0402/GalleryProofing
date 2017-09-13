class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :title
      t.integer :shipping_optio_price
      t.string :shipping_option_title
      t.text :terms_of_sales
      t.references :pricing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
