json.array!(@watermarks) do |watermark|
  json.extract! watermark, :id, :name, :text_name, :font_set, :color, :text_opacity_value, :image_url, :image_placement, :size, :image_opacity_value, :selected_as, :is_default, :brand_id
  json.url watermark_url(watermark, format: :json)
end
