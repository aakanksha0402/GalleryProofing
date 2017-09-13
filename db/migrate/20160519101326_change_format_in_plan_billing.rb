class ChangeFormatInPlanBilling < ActiveRecord::Migration
  def up
   change_column :plan_billings, :billing_date, 'date USING CAST(billing_date AS date)'
 end

 def down
   change_column :plan_billings, :billing_date, :string
 end
end
