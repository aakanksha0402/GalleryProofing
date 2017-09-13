class AddFixGroupToItemList < ActiveRecord::Migration
  def change
    add_reference :item_lists, :fix_group, index: true, foreign_key: true
  end
end
