class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.references :gallery_visitor, index: true, foreign_key: true
      t.string :shipping_method
      t.string :email
      t.string :phone_number
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_addr1
      t.string :shipping_addr2
      t.string :shipping_country_id
      t.string :shipping_city
      t.string :shipping_state_id
      t.string :shipping_postal_code
      t.string :payment_option
      t.string :billing_first_name
      t.string :billing_last_name
      t.string :billing_addr1
      t.string :billing_addr2
      t.string :billing_country_id
      t.string :billing_city
      t.string :billing_state_id
      t.string :billing_postal_code
      t.references :shipping_option, index: true, foreign_key: true
      t.string :notes_to_studio
      t.boolean :agree_to_terms
      t.string :total_price

      t.timestamps null: false
    end
  end
end
