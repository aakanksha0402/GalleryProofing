class AddMobileViewTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile_view_type, :boolean, :default => true
  end
end
