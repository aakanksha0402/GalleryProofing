class DiscountOfferType < ActiveRecord::Base
  belongs_to :discount_offer
  belongs_to :discount_type
  has_many :discounts, dependent: :destroy
end
