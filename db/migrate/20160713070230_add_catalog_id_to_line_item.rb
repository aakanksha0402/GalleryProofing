class AddCatalogIdToLineItem < ActiveRecord::Migration
  def change
    add_reference :line_items, :catalog, index: true, foreign_key: true
  end
end
