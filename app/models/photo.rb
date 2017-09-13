class Photo < ActiveRecord::Base
  #Associations
  belongs_to :imageable, polymorphic: true
  has_many :line_items, dependent: :destroy
  has_many :carts, through: :line_items
  has_many :favorites, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :label_photos, dependent: :destroy
  has_many :labels, through: :label_photos


  #Paperclip attachment
  has_attached_file :image, :styles => { :small => "150x150>", thumb: "315x200" },
                  :url  => "/assets/photos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"

  has_attached_file :watermark_image, :styles => { :small => "150x150>", thumb: "315x200" },
                  :url  => "/assets/images/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension"

  #Validation
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg']
# :content_type => /\Aimage\/.*\Z/


  validates_attachment_content_type :watermark_image, :content_type => ['image/jpeg', 'image/jpg']
# , :content_type => /\Aimage\/.*\Z/

  #functions
  # def photos
  #   self.amount
  # end
  #
  # def new_photos
  #   self.amount
  # end

  def decode_image_to_image_data(image)
    cid           = URI.unescape(image)
    filename      = "image#{Time.now.to_i}"
    file          = File.open("#{Rails.root.to_s}/public/tmp/#{filename}.png","wb")
    temp2         = Base64.decode64(cid)
    file.write(temp2)
    file.close
    f             = File.open("#{Rails.root.to_s}/public/tmp/#{filename}.png")
    self.image   = f
    f.close
    File.delete("#{Rails.root.to_s}/public/tmp/#{filename}.png")
	end

end
