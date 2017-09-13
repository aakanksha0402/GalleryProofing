json.array!(@pricings) do |pricing|
  json.extract! pricing, :id, :name, :is_deleted, :user_id, :pricing_style_id
  json.url pricing_url(pricing, format: :json)
end
