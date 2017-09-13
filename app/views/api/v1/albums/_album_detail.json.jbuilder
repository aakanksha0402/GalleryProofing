json.id album.id
json.name album.title
json.password album.password
json.parent_id album.parent
json.cover_photo_url Rails.application.secrets.url +  album.cover_url.url(:small)
json.photo_count album.photos.count