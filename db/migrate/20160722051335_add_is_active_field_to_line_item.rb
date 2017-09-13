class AddIsActiveFieldToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :is_active, :boolean
  end
end
