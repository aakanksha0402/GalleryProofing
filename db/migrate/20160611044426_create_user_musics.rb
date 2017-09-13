class CreateUserMusics < ActiveRecord::Migration
  def change
    create_table :user_musics do |t|
      t.references :playlist, index: true, foreign_key: true
      t.references :music, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
