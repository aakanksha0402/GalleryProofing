class AddAttachmentLogoToMobileappCustomLinks < ActiveRecord::Migration
  def self.up
    change_table :mobileapp_custom_links do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :mobileapp_custom_links, :logo
  end
end
