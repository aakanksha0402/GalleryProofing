json.stat "success"
json.albums do 
	json.array! @gallery.albums.get_first_level_albums do |album|
		json.id album.id
		json.name album.title
		json.password album.password
		json.parent_id album.parent
		json.cover_photo_url Rails.application.secrets.url +  album.cover_url.url(:small)
		json.photo_count album.photos.count
		
		#get the first level albums
		level_1_sub_albums = @gallery.albums.get_next_level_albums(1,album.id)
		if level_1_sub_albums.present?
			json.sub_albums do 
				json.array! level_1_sub_albums do |album|
					json.id album.id
					json.name album.title
					json.password album.password
					json.parent_id album.parent
					json.cover_photo_url Rails.application.secrets.url +  album.cover_url.url(:small)
					json.photo_count album.photos.count

					#get_second_level_albums
					level_2_sub_albums =  @gallery.albums.get_next_level_albums(2,album.id)
					if level_2_sub_albums.present?
						json.sub_albums do 
							json.array! level_2_sub_albums do |album|
								json.id album.id
								json.name album.title
								json.password album.password
								json.parent_id album.parent
								json.cover_photo_url Rails.application.secrets.url +  album.cover_url.url(:small)
								json.photo_count album.photos.count

								#get_second_level_albums
								level_3_sub_albums = @gallery.albums.get_next_level_albums(3,album.id)
								if level_3_sub_albums.present?
									json.sub_albums do 
										json.array! level_3_sub_albums do |album|
											json.id album.id
											json.name album.title
											json.password album.password
											json.parent_id album.parent
											json.cover_photo_url Rails.application.secrets.url +  album.cover_url.url(:small)
											json.photo_count album.photos.count
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