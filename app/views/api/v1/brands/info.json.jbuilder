json.stat "success"
json.brand do
	json.id @brand.id
	json.name @brand.brand_name
	json.is_default @brand.default
	json.website @brand.website_url
	json.homepage_url @brand.try(:studio_home_page).try(:subdomain) + "." + Rails.application.secrets.host
end