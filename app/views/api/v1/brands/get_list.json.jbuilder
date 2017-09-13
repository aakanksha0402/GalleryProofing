json.stat "success"
json.brands do
	json.array! @brands do |brand|
		json.id brand.id
		json.name brand.brand_name
		json.is_default brand.default
		json.subdomain brand.try(:studio_home_page).try(:subdomain)
		json.custom_domain ""
		json.locale ""
	end
end
json.results_returned  ""
json.total_results @brands.count

