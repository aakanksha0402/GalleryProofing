class CheckoutStatus < ActiveRecord::Base
	# associations
	has_one :checkouts, class_name: 'Checkout',primary_key: 'id', foreign_key: 'checkout_status_id', dependent: :destroy
end
