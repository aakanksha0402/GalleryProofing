class CreateItemLists < ActiveRecord::Migration
  def change
    create_table :item_lists do |t|
      t.float :size_one
      t.float :size_two
      t.float :depth
      t.string :group_name
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
