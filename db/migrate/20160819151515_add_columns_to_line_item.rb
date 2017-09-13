class AddColumnsToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :from, :string
  end
end
