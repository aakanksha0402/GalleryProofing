class Watermark < ActiveRecord::Base
  belongs_to :brand

  validates :name, presence: true

  # has_attached_file :avatar,:processors => [:watermark]
  # , :styles => { :small => "108x76" }
  has_attached_file :avatar,
					:styles => lambda { |attachment| {
                                 :thumb => '150x150>',
                                 :original => { :geometry => '800x800>'}
                               }},
                    :url    => '/assets/attachment/:id/:style/:basename.:extension',
                    :path   => ':rails_root/public/assets/attachment/:id/:style/:basename.:extension',
                    :default_url => "/images/:style/mising.png"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png']
  has_attached_file :watermark_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :watermark_image, :content_type => ['image/jpeg', 'image/jpg', 'image/png']
  has_attached_file :watermark_sample_image
  validates_attachment_content_type :watermark_sample_image, :content_type => ['image/jpeg', 'image/jpg', 'image/png']
end
