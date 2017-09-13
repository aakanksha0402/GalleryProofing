class DiscountType < ActiveRecord::Base
  has_many :invoices, dependent: :destroy
end
