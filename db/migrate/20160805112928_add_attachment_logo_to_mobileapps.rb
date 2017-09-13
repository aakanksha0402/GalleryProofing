class AddAttachmentLogoToMobileapps < ActiveRecord::Migration
  def self.up
    change_table :mobileapps do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :mobileapps, :logo
  end
end
