class AddFieldToPlanBilling < ActiveRecord::Migration
  def change
    add_reference :plan_billings, :music_plan, index: true, foreign_key: true
  end
end
