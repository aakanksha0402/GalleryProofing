class Discount < ActiveRecord::Base
  has_many :discount_items_lists,dependent: :destroy
  has_many :discount_groups_lists,dependent: :destroy
  has_many :discount_cart_values,dependent: :destroy
  has_many :discount_bsgs_buy_items,dependent: :destroy
  has_many :discount_bsgs_get_items,dependent: :destroy
  has_many :package_discounts,dependent: :destroy
  belongs_to :discount_offer_type
  belongs_to :pricing
end
