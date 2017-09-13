class CreateColorLogos < ActiveRecord::Migration
  def change
    create_table :color_logos do |t|
      t.string :font_set
      t.string :theme
      t.string :primary_color
      t.string :secondary_color

      t.timestamps null: false
    end
  end
end
