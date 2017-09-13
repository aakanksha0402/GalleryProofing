json.array!(@brands) do |brand|
  json.extract! brand, :id, :user_id, :brand_name, :website_url, :email, :address1, :address2, :city, :country, :pincode, :phone_number, :default
  json.url brand_url(brand, format: :json)
end
