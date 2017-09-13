class DiscountBsgsBuyItem < ActiveRecord::Base
  belongs_to :discount
  belongs_to :catalog
end
