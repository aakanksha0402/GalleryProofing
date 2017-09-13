json.stat "success"
json.id @photo.id
json.name @photo.image_file_name
json.mime_type @photo.image_content_type
json.width Paperclip::Geometry.from_file(@photo.image).width
json.height Paperclip::Geometry.from_file(@photo.image).width
json.url do
	json.original Rails.application.secrets.url +  @photo.image.url
end
