json.stat "success"
json.categories do 
	json.array! @categories do |category|
		json.partial! 'api/v1/categories/category_detail', category: category
	end 
end