json.stat "success"
json.events do 
	json.array! @galleries do |gallery|
		json.id gallery.id
		json.brand_id gallery.brand.id
		json.name gallery.name
		json.password gallery.try(:custom_gallery_layout).try(:password)
		json.category_id gallery.try(:custom_gallery_layout).try(:category_id)
		json.view_url @brand.try(:studio_home_page).try(:subdomain) + "." + Rails.application.secrets.host + "gallery/" + gallery.id.to_s
		json.created gallery.created_at
		json.event_date gallery.shoot_date
		json.release_date gallery.release_date
		json.gallery_expiration_date gallery.expiration_date
		json.contact_id gallery.contact_id
		json.cover_photo Rails.application.secrets.url +  gallery.cover_url.url(:small)
		json.photo_count gallery.gallery_photos.count + gallery.albums.includes(:album_photos).count(:album_photos)
		json.albums do
			json.array! gallery.albums.get_first_level_albums do |album|
				json.id album.id
				json.name album.title
				#get the first level albums
				level_1_sub_albums = gallery.albums.get_next_level_albums(1,album.id)
				if level_1_sub_albums.present?
					json.sub_albums do 
						json.array! level_1_sub_albums do |album|
							json.id album.id
							json.name album.title
							#get_second_level_albums
							level_2_sub_albums =  gallery.albums.get_next_level_albums(2,album.id)
							if level_2_sub_albums.present?
								json.sub_albums do 
									json.array! level_2_sub_albums do |album|
										json.id album.id
										json.name album.title
										
										#get_second_level_albums
										level_3_sub_albums = gallery.albums.get_next_level_albums(3,album.id)
										if level_3_sub_albums.present?
											json.sub_albums do 
												json.array! level_3_sub_albums do |album|
													json.id album.id
													json.name album.title	
												end
											end 
										end
									end 
								end 
							end		
											
						end 
					end 
				end
			end
		end
	end 
end