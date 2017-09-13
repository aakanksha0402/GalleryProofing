class AddDefaultValueToNotifications < ActiveRecord::Migration
  def change
  	change_column :notifications, :is_dismiss, :boolean, :default => false
  end
end
