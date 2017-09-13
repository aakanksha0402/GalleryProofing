class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :title
      t.string :theme
      t.string :style
      t.string :mood
      t.string :song_type
      t.string :tempo
      t.string :instrument
      t.string :artist
      t.references :music_plan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
