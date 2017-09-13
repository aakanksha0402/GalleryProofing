class ItemDiscount < ActiveRecord::Base
  belongs_to :discount_offer_type
  belongs_to :pricing
end
