class PackageDiscount < ActiveRecord::Base
  belongs_to :discount
  has_many :package_discount_items,dependent: :destroy
end
