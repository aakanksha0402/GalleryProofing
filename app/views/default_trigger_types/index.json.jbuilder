json.array!(@default_trigger_types) do |default_trigger_type|
  json.extract! default_trigger_type, :id, :name, :active
  json.url default_trigger_type_url(default_trigger_type, format: :json)
end
