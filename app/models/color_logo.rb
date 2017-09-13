class ColorLogo < ActiveRecord::Base
  belongs_to :brand
  has_many :gallery_layouts
  belongs_to :custom_gallery_layout
  belongs_to :studio_home_page
  has_many :invoices, dependent: :destroy
  has_many :mobileapps,dependent: :destroy
  has_one :custom_gallery_layout, dependent: :destroy

  FONT_SET = [['A - Branadon, Baskerville','A - Branadon, Baskerville'], ['B - ProximaNova','B- ProximaNova'], ['C - Baskerville, OpenSans','C - Baskerville, OpenSans']]
  THEME = [['Light', 'Light'], ['Dark', 'Dark']]

  has_attached_file :gallery_logo, styles: {small: "150x150"}
  validates_attachment_content_type :gallery_logo, :content_type => ['image/jpeg', 'image/jpg']

  has_attached_file :email_logo, styles: {small: "150x150"}
  validates_attachment_content_type :email_logo, :content_type => ['image/jpeg', 'image/jpg']

  validates :name, presence: true
  validates :theme, presence: true

end
