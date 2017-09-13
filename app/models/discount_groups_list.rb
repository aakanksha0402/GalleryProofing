class DiscountGroupsList < ActiveRecord::Base
  belongs_to :group
  belongs_to :discount
end
