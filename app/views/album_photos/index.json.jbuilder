json.array!(@album_photos) do |album_photo|
  json.extract! album_photo, :id, :album_id
  json.url album_photo_url(album_photo, format: :json)
end
