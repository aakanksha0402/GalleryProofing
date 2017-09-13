json.stat "success"
json.event_defaults do 
	json.array! @gallery_layouts do |event|
		json.id event.id
		json.name event.name
		json.is_default event.is_default
	end 
end