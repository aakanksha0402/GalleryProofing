class CreateSalesTaxes < ActiveRecord::Migration
  def change
    create_table :sales_taxes do |t|
      t.string :title
      t.boolean :digital_charge
      t.boolean :shipping_tax
      t.decimal :tax_percent
      t.decimal :vat
      t.references :pricing, index: true, foreign_key: true
      t.boolean :is_deleted

      t.timestamps null: false
    end
  end
end
