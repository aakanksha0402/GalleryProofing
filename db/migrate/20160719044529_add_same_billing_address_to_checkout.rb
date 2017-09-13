class AddSameBillingAddressToCheckout < ActiveRecord::Migration
  def change
    add_column :checkouts, :same_billing_address, :boolean
  end
end
