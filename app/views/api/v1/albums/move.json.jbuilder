json.stat "success"
json.album do 
	json.partial! 'api/v1/albums/album_detail', album: @album
end 