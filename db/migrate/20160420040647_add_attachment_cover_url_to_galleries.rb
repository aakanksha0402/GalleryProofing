class AddAttachmentCoverUrlToGalleries < ActiveRecord::Migration
  def self.up
    change_table :galleries do |t|
      t.attachment :cover_url
    end
  end

  def self.down
    remove_attachment :galleries, :cover_url
  end
end
