json.array!(@albums) do |album|
  json.extract! album, :id, :gallery_id, :title
  json.url album_url(album, format: :json)
end
