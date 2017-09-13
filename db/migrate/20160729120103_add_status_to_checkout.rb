class AddStatusToCheckout < ActiveRecord::Migration
  def change
    add_reference :checkouts, :checkout_status, index: true, foreign_key: true
  end
end
