class AddFieldPayedUsingInCheckout < ActiveRecord::Migration
  def change
    add_column :checkouts, :payed_using, :string
  end
end
