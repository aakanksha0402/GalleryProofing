class CreateGatewaySetups < ActiveRecord::Migration
  def change
    create_table :gateway_setups do |t|
      t.string :name
      t.string :public_key
      t.string :private_key
      t.string :environment
      t.string :merchant_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
