class AddBrandToMobileapps < ActiveRecord::Migration
  def change
    add_reference :mobileapps, :brand, index: true, foreign_key: true
  end
end
