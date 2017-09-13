class ChangeIntegerLimitInOrders < ActiveRecord::Migration
  def change
  	change_column :orders, :phone_no, :integer, limit: 8
  end
end
