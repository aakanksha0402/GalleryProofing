class AddAttachmentPhotoToMusics < ActiveRecord::Migration
  def self.up
    change_table :musics do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :musics, :photo
  end
end
