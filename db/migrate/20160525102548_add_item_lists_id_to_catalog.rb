class AddItemListsIdToCatalog < ActiveRecord::Migration
  def change
    add_reference :catalogs, :item_list, index: true, foreign_key: true
  end
end
