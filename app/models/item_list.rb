class ItemList < ActiveRecord::Base
  belongs_to :group
  belongs_to :fix_group ,foreign_key: 'fix_group_id'
  has_many :item_list_sub_items, dependent: :destroy
  has_many :sub_items, :through => :item_list_sub_items
  accepts_nested_attributes_for :item_list_sub_items
end
