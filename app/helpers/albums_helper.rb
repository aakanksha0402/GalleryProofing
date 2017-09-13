module AlbumsHelper
  def get_child_albums(children_album = [],album_id)
    children_album << album_id

    @albums = Album.find(album_id).children_album
    puts "--------------------------------------"
    puts @albums.as_json
    puts "--------------------------------------"

    if @albums.count == 0
      return nil
    else
      return @albums
    end
  end
end
