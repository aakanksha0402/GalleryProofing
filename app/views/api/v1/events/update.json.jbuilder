json.stat "success"
json.event do 
	json.partial! 'api/v1/events/event_detail', gallery: @gallery
end
