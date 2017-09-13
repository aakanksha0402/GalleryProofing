class AddColumnsToGatewaySetup < ActiveRecord::Migration
  def change
    add_column :gateway_setups, :user_name, :string
    add_column :gateway_setups, :password, :string
    add_column :gateway_setups, :signature, :string
    add_column :gateway_setups, :secure_merchant_account_id, :string
  end
end
