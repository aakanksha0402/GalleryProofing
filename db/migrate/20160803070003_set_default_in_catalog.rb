class SetDefaultInCatalog < ActiveRecord::Migration
  def change
    change_column_default(:catalogs, :cost, 0.00)
    change_column_default(:catalogs, :price, 0.00)
    change_column_default(:catalogs, :profit, 0.00)
  end
end
