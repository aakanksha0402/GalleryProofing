json.array!(@galleries) do |gallery|
  json.extract! gallery, :id, :name, :shoot_date, :release_date, :expiration_date, :cover_url, :archive
  json.url gallery_url(gallery, format: :json)
end
