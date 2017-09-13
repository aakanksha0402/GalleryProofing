class AddIsActiveFieldToCart < ActiveRecord::Migration
  def change
    add_column :carts, :is_active, :boolean, default: true
  end
end
