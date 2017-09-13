class GalleryVisitor < ActiveRecord::Base
  belongs_to :gallery
  has_many :favorites, dependent: :destroy
  has_many :share_favorites, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :checkouts, dependent: :destroy

  def gallery_visitor_values
    @cart_items = self.carts.where("carts.is_active = ?",true)
    @favorites = self.favorites.count
    return @cart_items,@favorites
  end

  def self.to_csv()
    attributes = %w{"Gallery Name" Visitor "Last Activity" Favotites "Free Digitals" "Cart Items" Orders}
    CSV.generate(headers: true) do |csv|
      csv.add_row attributes
        all.each do |gallery_visitor|
          @total_label_photos = 0
          gallery_visitor.gallery.contact.galleries.each do |gallery|
            gallery.labels.each do |label1|
              @total_label_photos = @total_label_photos + label1.photos.count
            end
          end
          csv.add_row [gallery_visitor.gallery.name,gallery_visitor.email,gallery_visitor.updated_at.strftime("%d-%b-%Y %l:%M:%S %P"),gallery_visitor.favorites.count,"#{@total_label_photos}",gallery_visitor.gallery_visitor_values[0].count,gallery_visitor.checkouts.ids.join(",")]
        end
    end
  end
end
