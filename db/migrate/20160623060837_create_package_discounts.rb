class CreatePackageDiscounts < ActiveRecord::Migration
  def change
    create_table :package_discounts do |t|
      t.references :discount, index: true, foreign_key: true
      t.integer :package_qty

      t.timestamps null: false
    end
  end
end
