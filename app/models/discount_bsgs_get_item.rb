class DiscountBsgsGetItem < ActiveRecord::Base
  belongs_to :discount
  belongs_to :catalog
end
