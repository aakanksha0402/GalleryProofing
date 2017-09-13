class ChangeDefaultOfItemListId < ActiveRecord::Migration
  def change
    change_column_default :catalogs, :item_list_id, nil
  end
end
