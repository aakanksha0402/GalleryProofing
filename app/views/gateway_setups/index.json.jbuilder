json.array!(@gateway_setups) do |gateway_setup|
  json.extract! gateway_setup, :id, :name, :public_key, :private_key, :environment, :merchant_id, :user_id
  json.url gateway_setup_url(gateway_setup, format: :json)
end
