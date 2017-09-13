class AddAttachmentEmailLogoToColorLogos < ActiveRecord::Migration
  def self.up
    change_table :color_logos do |t|
      t.attachment :email_logo
    end
  end

  def self.down
    remove_attachment :color_logos, :email_logo
  end
end
