json.array!(@musics) do |music|
  json.extract! music, :id, :title, :theme, :style, :mood, :song_type, :tempo, :instrument, :artist, :music_plan_id
  json.url music_url(music, format: :json)
end
