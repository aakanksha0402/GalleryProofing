json.stat "success"
json.photos do
	json.array! @photos.each do |photo|
		json.id photo.id
		json.name photo.image_file_name
		json.mime_type photo.image_content_type
		json.width Paperclip::Geometry.from_file(photo.image).width
		json.height Paperclip::Geometry.from_file(photo.image).width
		json.url do
			json.original Rails.application.secrets.url +  photo.image.url
		end
	end 
end 
json.page params[:page].present? ? params[:page] : 1 
json.results_returned @photos.count
json.total_pages @photos.total_pages
json.total_results @photos.total_count
