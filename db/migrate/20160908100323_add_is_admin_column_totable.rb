class AddIsAdminColumnTotable < ActiveRecord::Migration
  def change
    add_column :gallery_visitors, :is_admin, :boolean, :default => false
  end
end
