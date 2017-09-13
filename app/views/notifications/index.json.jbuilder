json.array!(@notifications) do |notification|
  json.extract! notification, :id, :notification_from, :id_from, :brand_id, :is_dismiss
  json.url notification_url(notification, format: :json)
end
