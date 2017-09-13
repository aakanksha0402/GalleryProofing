json.array!(@music_categories) do |music_category|
  json.extract! music_category, :id, :name
  json.url music_category_url(music_category, format: :json)
end
