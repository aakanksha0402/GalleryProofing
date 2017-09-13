json.id gallery.id
json.brand_id gallery.brand.id
json.name gallery.name
json.password gallery.try(:custom_gallery_layout).try(:password)
json.category_id gallery.try(:custom_gallery_layout).try(:category_id)
json.view_url gallery.brand.try(:studio_home_page).try(:subdomain) + "." + Rails.application.secrets.host + "gallery/" + gallery.id.to_s
json.created gallery.created_at
json.event_date gallery.shoot_date
json.release_date gallery.release_date
json.gallery_expiration_date gallery.expiration_date
json.contact_id gallery.contact_id
json.cover_photo Rails.application.secrets.url +  gallery.cover_url.url(:small)
json.photo_count gallery.gallery_photos.count + gallery.albums.includes(:album_photos).count(:album_photos)

