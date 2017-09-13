class AddNameToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :first_name, :string
    add_column :notifications, :last_name, :string
    add_column :notifications, :amount, :float
  end
end
