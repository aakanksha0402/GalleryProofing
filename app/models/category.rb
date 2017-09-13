class Category < ActiveRecord::Base
  belongs_to :brand
  has_many :custom_gallery_layouts, dependent: :destroy

  has_attached_file :category_cover_pic, styles: {small: "50x50", show: "360x276"}
  validates :name, presence: {message: "Please enter a category name to proceed."}

  validates_attachment_content_type :category_cover_pic, :content_type => ['image/jpeg', 'image/jpg']

  default_scope { order("priority ASC") }
end
