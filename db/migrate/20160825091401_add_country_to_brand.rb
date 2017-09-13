class AddCountryToBrand < ActiveRecord::Migration
  def change
    add_reference :brands, :primary_country, index: true
    add_reference :brands, :brand_country, index: true
  end
end
