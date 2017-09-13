class Group < ActiveRecord::Base
  belongs_to :fix_group
  belongs_to :pricing
  has_many :item_lists , dependent: :destroy
  has_many :catalogs, dependent: :destroy
  has_many :discount_groups_lists,dependent: :destroy
end
