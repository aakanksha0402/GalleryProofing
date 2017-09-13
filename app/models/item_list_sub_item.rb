class ItemListSubItem < ActiveRecord::Base
  belongs_to :item_list
  belongs_to :sub_item
end
