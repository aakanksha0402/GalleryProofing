class CreateItemListSubItems < ActiveRecord::Migration
  def change
    create_table :item_list_sub_items do |t|
      t.references :item_list, index: true, foreign_key: true
      t.references :sub_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
