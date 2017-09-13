class AddFieldsToMusicLibrary < ActiveRecord::Migration
  def up
    add_attachment :music_libraries, :music
    add_attachment :music_libraries, :photo

  end
  def down
    remove_attachment :music_libraries, :music
    remove_attachment :music_libraries, :photo
  end
end
