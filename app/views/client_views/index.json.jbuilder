json.array!(@client_views) do |client_view|
  json.extract! client_view, :id
  json.url client_view_url(client_view, format: :json)
end
