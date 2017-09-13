class AddDescriptionFieldToDiscount < ActiveRecord::Migration
  def change
    add_column :discounts, :description, :text
  end
end
