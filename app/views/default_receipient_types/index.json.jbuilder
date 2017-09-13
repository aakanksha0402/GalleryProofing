json.array!(@default_receipient_types) do |default_receipient_type|
  json.extract! default_receipient_type, :id, :name, :active
  json.url default_receipient_type_url(default_receipient_type, format: :json)
end
