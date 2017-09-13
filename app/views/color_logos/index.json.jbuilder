json.array!(@color_logos) do |color_logo|
  json.extract! color_logo, :id, :font_set, :theme, :primary_color, :secondary_color
  json.url color_logo_url(color_logo, format: :json)
end
