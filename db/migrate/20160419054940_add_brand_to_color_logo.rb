class AddBrandToColorLogo < ActiveRecord::Migration
  def change
    add_reference :color_logos, :brand, index: true, foreign_key: true
  end
end
