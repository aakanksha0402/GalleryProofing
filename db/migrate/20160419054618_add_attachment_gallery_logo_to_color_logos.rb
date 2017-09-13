class AddAttachmentGalleryLogoToColorLogos < ActiveRecord::Migration
  def self.up
    change_table :color_logos do |t|
      t.attachment :gallery_logo
    end
  end

  def self.down
    remove_attachment :color_logos, :gallery_logo
  end
end
