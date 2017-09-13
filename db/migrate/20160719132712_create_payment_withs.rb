class CreatePaymentWiths < ActiveRecord::Migration
  def change
    create_table :payment_withs do |t|
      t.string :mode

      t.timestamps null: false
    end
  end
end
