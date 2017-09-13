class CreateCheckoutStatuses < ActiveRecord::Migration
  def change
    create_table :checkout_statuses do |t|
      t.string :status

      t.timestamps null: false
    end
  end
end
