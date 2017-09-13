class Gallery < ActiveRecord::Base
  extend FriendlyId
  friendly_id :custom_link, use: [:slugged,:finders]

  belongs_to :brand
  belongs_to :contact
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :gallery_photos, dependent: :destroy
  has_one :custom_gallery_layout, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :gallery_shares, dependent: :destroy
  has_many :gallery_visitors, dependent: :destroy
  has_many :photos, as: :imageable, dependent: :destroy
  has_many :mobileapps,dependent: :destroy
  has_many :labels, dependent: :destroy
  has_one :privilege, dependent: :destroy

  accepts_nested_attributes_for :photos
  validates :name, presence: true
  validates :custom_link, uniqueness: {case_sensitive: true}, allow_nil: true

  has_attached_file :cover_url, :styles => { :small => "108x76", thumb: "315x200" }
  validates_attachment_content_type :cover_url, :content_type => ['image/jpeg', 'image/jpg']

  scope :gallery_id, lambda { |gname| where("galleries.id = ?", gname)}
  scope :gallery_name, lambda { |gname| where("name LIKE ?", "%#{gname}%")}
  scope :gallery_shoot_date, lambda { |shootdate| where("shoot_date LIKE ?", "%#{shootdate}%")}
  scope :gallery_status, lambda { |status| where("status LIKE ?", "%#{status}%")}
  scope :gallery_preregistered,lambda { |p| joins("LEFT JOIN custom_gallery_layouts on galleries.id = custom_gallery_layouts.gallery_id").where("custom_gallery_layouts.preregistration = ?", true)}
  scope :gallery_archived,lambda { |a| joins("LEFT JOIN custom_gallery_layouts on galleries.id = custom_gallery_layouts.gallery_id").where("custom_gallery_layouts.archiving NOT LIKE ?", "")}
  scope :gallery_access_privacy,lambda { |privacy| joins("LEFT JOIN custom_gallery_layouts on galleries.id = custom_gallery_layouts.gallery_id").where("custom_gallery_layouts.gallery_access_privacy LIKE ?", "#{privacy}")}

    # LAYOUT  = ['Black with White','White with Gray']
  # def should_generate_new_friendly_id?
  #   new_record?
  # end

  def gallery_visitor
    @gallery_visitors = self.gallery_visitors
  end

  def orders
    @gallery_visitors = self.gallery_visitor
    @orders = Checkout.where("gallery_visitor_id IN(?)", @gallery_visitors.pluck(:id))
  end

  def carts
    @gallery_visitors = self.gallery_visitor
    @carts = Cart.includes(:line_items).where("carts.gallery_visitor_id IN(?) AND carts.is_active = ?", @gallery_visitors.pluck(:id), true)
    @line_items = LineItem.where("cart_id IN(?)", @carts.pluck(:id))
    return @carts, @line_items
  end

  def not_placed_order
    @carts = self.carts[0]
    @array = Array.new
    @carts.each do |cart|
      if cart.line_items.count == 0
        @array << cart.id
      end
    end
    @array.count
  end

  def favorites
    @gallery_visitors = self.gallery_visitor
    @favorites = Favorite.where("gallery_visitor_id IN(?)", @gallery_visitors.pluck(:id))
  end

  def photos
    photos_with_albums
  end

  def photos_with_albums
    Photo.where("(imageable_type='Gallery' AND imageable_id in (?)) OR (imageable_type='Album' AND imageable_id in (?))",self.id,Gallery.find(self.id).albums.ids)
  end
end
