json.stat "success"
json.category do 
	json.partial! 'api/v1/categories/category_detail', category: @category
end