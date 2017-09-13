class AddDefaultToItemListIdOfCatalogs < ActiveRecord::Migration
  def change
    change_column_default :catalogs, :item_list_id, 0
  end
end
