class Shipping < ActiveRecord::Base
  belongs_to :pricing
  has_many :shipping_options,dependent: :destroy
end
