class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.references :pricing, index: true, foreign_key: true
      t.string :type
      t.references :group, index: true, foreign_key: true
      t.references :fix_group, index: true, foreign_key: true
      t.boolean :checked
      t.text :discription
      t.decimal :cost
      t.decimal :price
      t.decimal :profit
      t.decimal :shipping_charge
      t.boolean :shipping_charge_apply
      t.float :print_size_one
      t.float :print_size_two
      t.float :depth
      t.string :sub_item_name
      t.boolean :is_deleted

      t.timestamps null: false
    end
  end
end
