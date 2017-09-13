class AddWatermarkToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :apply_watermark, :boolean
  end
end
