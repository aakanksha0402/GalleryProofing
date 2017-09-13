class AddMusicLibraryToUserMusic < ActiveRecord::Migration
  def change
    add_reference :user_musics, :music_library, index: true, foreign_key: true
  end
end
