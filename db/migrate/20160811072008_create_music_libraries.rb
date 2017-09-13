class CreateMusicLibraries < ActiveRecord::Migration
  def change
    create_table :music_libraries do |t|
      t.string :title
      t.string :singer
      t.string :released_date
      t.string :theme

      t.timestamps null: false
    end
  end
end
