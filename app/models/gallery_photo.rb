class GalleryPhoto < ActiveRecord::Base
  belongs_to :gallery
  has_attached_file :photo, :styles => { :small => "150x150>" },
                  :url  => "/assets/gallery_photos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/gallery_photos/:id/:style/:basename.:extension"

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/#:content_type => ['image/jpeg', 'image/jpg', 'image/png']
end
