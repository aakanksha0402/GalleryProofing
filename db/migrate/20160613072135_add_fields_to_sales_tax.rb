class AddFieldsToSalesTax < ActiveRecord::Migration
  def change
    add_column :sales_taxes, :state_id, :integer,default: 0
  end
end
