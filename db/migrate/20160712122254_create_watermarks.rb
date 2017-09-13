class CreateWatermarks < ActiveRecord::Migration
  def change
    create_table :watermarks do |t|
      t.string :name
      t.string :text_name
      t.string :font_set
      t.string :color
      t.string :text_opacity_value
      t.string :image_url
      t.string :image_placement
      t.string :size
      t.string :image_opacity_value
      t.boolean :selected_as
      t.boolean :is_default
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
