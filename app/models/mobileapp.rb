class Mobileapp < ActiveRecord::Base

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  belongs_to :brand
  # has_many :mobileapp_photos,dependent: :destroy
  has_many :mobileapp_custom_links,dependent: :destroy
  has_many :mobileapp_shares,dependent: :destroy
  belongs_to :color_logo
  belongs_to :gallery
  has_many :photos, as: :imageable, dependent: :destroy

  scope :gallery_find, -> (gallery_id) { where gallery_id: gallery_id }
  scope :mobileapp_name, lambda { |mname| where("name LIKE ?", "%#{mname}%")}
  # scope :gallery, lambda { |gname| where("gallery_id = ?", gname.to_i)}
  has_attached_file :logo, :styles =>{ 
    :small => {:geometry => "150x150>", :processors => [:cropper]}, 
    :large => {:geometry => "500x500>"} },
                  :url  => "/assets/mobileapps_logo/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/mobileapps_logo/:id/:style/:basename.:extension"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: { message: "Please enter the name of the mobile app.." }

  LANGUAGE = ['Danish', 'Dutch', 'English (UK)', 'English (US)', 'Finnish', 'French', 'German', 'Italian', 'Norwegian', 'Portuguese (Brazil)', 'Portuguese (Portugal)', 'Slovenian', 'Spanish', 'Swedish']

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end



end
