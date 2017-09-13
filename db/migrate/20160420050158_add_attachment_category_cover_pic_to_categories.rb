class AddAttachmentCategoryCoverPicToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.attachment :category_cover_pic
    end
  end

  def self.down
    remove_attachment :categories, :category_cover_pic
  end
end
