class AddColumnToWatermarks < ActiveRecord::Migration
  def change
  	change_column :watermarks, :image_opacity_value, 'integer USING CAST(image_opacity_value AS integer)'
  	change_column :watermarks, :text_opacity_value, 'integer USING CAST(text_opacity_value AS integer)'
  	change_column :watermarks, :color, 'boolean USING CAST(color AS boolean)'
  	add_column :watermarks, :image_url2, :string
  	add_column :watermarks, :is_first, :boolean
  end
end
