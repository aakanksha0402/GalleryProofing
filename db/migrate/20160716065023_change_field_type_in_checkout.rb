class ChangeFieldTypeInCheckout < ActiveRecord::Migration
  def up
    change_column :checkouts, :shipping_method, 'boolean USING CAST(shipping_method AS boolean)'
    change_column :checkouts, :payment_option, 'boolean USING CAST(payment_option AS boolean)'
  end

  def down
    change_column :checkouts, :shipping_method, :string
    change_column :checkouts, :payment_option, :string
  end
end
