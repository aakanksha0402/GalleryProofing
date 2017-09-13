class CreateDiscountGroupsLists < ActiveRecord::Migration
  def change
    create_table :discount_groups_lists do |t|
      t.references :group, index: true, foreign_key: true
      t.boolean :active
      t.references :discount, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
