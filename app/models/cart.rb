class Cart < ActiveRecord::Base
  belongs_to :gallery_visitor
  has_many :line_items, dependent: :destroy
  has_many :used_promocodes, dependent: :destroy
  has_many :photos, through: :line_items

 def total_price
   self.line_items
   @total = 0
   @price = 1
   line_items.each do |line_item|
     if line_item.catalog.catalog_price != 0.00
       @total += line_item.catalog.catalog_price * line_item.quantity
      #  @price *= @total
     else
      line_item.catalog.digital_media_prices.each do |sub_digital|
        if line_item.from == "2"
          @total += sub_digital.indiviual_photo_price * line_item.quantity
        else
          @total += sub_digital.all_gallery_photo_price * line_item.quantity
        end
      end
     end
   end
   @total
 end


 def cart_values
   puts "____________#{self.as_json}_____________"
   @line_items = self.line_items
   @line_items.each do |line_item|
     @line_item_array = line_item.photo
     @catalog = line_item.catalog
   end
   puts @line_item_array.as_json
   puts "********************************"
   return @line_items,@catalog
 end
end
