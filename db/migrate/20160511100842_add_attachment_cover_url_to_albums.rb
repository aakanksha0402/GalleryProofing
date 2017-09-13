class AddAttachmentCoverUrlToAlbums < ActiveRecord::Migration
  def self.up
    change_table :albums do |t|
      t.attachment :cover_url
    end
  end

  def self.down
    remove_attachment :albums, :cover_url
  end
end
