class SubItem < ActiveRecord::Base
	has_many :item_list_sub_items, dependent: :destroy
	has_many :item_lists, :through => :item_list_sub_items
	accepts_nested_attributes_for :item_list_sub_items
end
