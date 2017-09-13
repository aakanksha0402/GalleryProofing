class AddBrandIdToCheckout < ActiveRecord::Migration
  def change
    add_reference :checkouts, :brand, index: true, foreign_key: true
    add_column :checkouts, :studio_internal_notes, :string
  end
end
