class CreateDataPlans < ActiveRecord::Migration
  def change
    create_table :data_plans do |t|
      t.string :photos_number
      t.string :mobile_apps_number
      t.string :invoices_number
      t.string :data_period
      t.string :plan_price
      t.string :stripe_id

      t.timestamps null: false
    end
  end
end
