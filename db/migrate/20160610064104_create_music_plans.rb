class CreateMusicPlans < ActiveRecord::Migration
  def change
    create_table :music_plans do |t|
      t.string :name
      t.string :no_of_songs
      t.string :songs_per_playlist
      t.string :data_period
      t.string :svg
      t.string :stripe_id

      t.timestamps null: false
    end
  end
end
