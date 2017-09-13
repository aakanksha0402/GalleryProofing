class AlbumPhoto < ActiveRecord::Base
  belongs_to :album
  has_attached_file :image

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/png']
end
