class CreatePackageDiscountItems < ActiveRecord::Migration
  def change
    create_table :package_discount_items do |t|
      t.references :package_discount, index: true, foreign_key: true
      t.integer :catalog_id

      t.timestamps null: false
    end
  end
end
