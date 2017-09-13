json.array!(@automation_series) do |automation_series|
  json.extract! automation_series, :id, :name
  json.url automation_series_url(automation_series, format: :json)
end
