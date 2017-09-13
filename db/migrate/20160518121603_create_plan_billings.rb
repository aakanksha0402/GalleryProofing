class CreatePlanBillings < ActiveRecord::Migration
  def change
    create_table :plan_billings do |t|
      t.references :data_plan, index: true, foreign_key: true
      t.string :credit
      t.string :billing_date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
