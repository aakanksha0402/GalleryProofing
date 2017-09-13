class AddFieldToUserMusic < ActiveRecord::Migration
  def change
    add_reference :user_musics, :user, index: true, foreign_key: true
  end
end
