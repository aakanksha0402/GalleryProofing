json.array!(@song_libraries) do |song_library|
  json.extract! song_library, :id
  json.url song_library_url(song_library, format: :json)
end
