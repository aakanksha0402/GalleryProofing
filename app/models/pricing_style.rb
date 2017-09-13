class PricingStyle < ActiveRecord::Base
	has_many :pricings, dependent: :destroy
end
