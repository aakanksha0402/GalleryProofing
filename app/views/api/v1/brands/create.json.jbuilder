json.stat "success"
json.brand do
	json.id @brand.id
	json.name @brand.brand_name
	json.is_default @brand.default
	json.website @brand.website_url
	json.homepage_url @brand.try(:studio_home_page).try(:subdomain) + "." + Rails.application.secrets.host
	json.email @brand.email
	json.local ""
	json.phone @brand.phone_number
	json.subdomain @brand.try(:studio_home_page).try(:subdomain)
	json.address do
		json.address1 @brand.address1
		json.address2 @brand.address2
		json.city @brand.city
		json.country @brand.brand_country
		json.zip_postal @brand.pincode
	end

end