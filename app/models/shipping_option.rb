class ShippingOption < ActiveRecord::Base
  belongs_to :shipping
  has_one :checkout
end
