class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :photo
  belongs_to :catalog
  belongs_to :checkout

  cattr_accessor :promocode

  DURATION = [["30 Days",30],["60 Days",60],["90 Days",90],["180 Days",180],["1 Year", 365]]
  scope :days_ago, lambda {|no_of_days| where('line_items.created_at > ?', no_of_days.to_i.days.ago)}

  
  # def item_discount(all_discounts)
  #   all_discounts = all_discounts
  #   item_discount = DiscountItemsList.where(discount_id: all_discounts.pluck, catalog_id: self.catalog_id, active: true)
  #   # puts "------------Item Discount-------------"
  #   # puts "----------------------------------------"
  #   # puts item_discount.as_json
  #   # puts "----------------------------------------"
  #   return item_discount
  # end

  # def group_discount(all_discounts)
  #   group = Group.find(catalog.group_id)
  #   group_discount = DiscountGroupsList.where(discount_id: all_discounts.pluck, group_id: group.id, active: true)
  #   # puts "------------Group Discount-------------"
  #   # puts "----------------------------------------"
  #   # puts group_discount.as_json
  #   # puts "----------------------------------------"
  #   return group_discount
  # end

  # def package_discount(all_discounts)
  #   package_discounts = PackageDiscount.where(discount_id: all_discounts.pluck)
  #   package_discount = PackageDiscountItem.where(package_discount_id: package_discounts.pluck, catalog_id: self.catalog_id)
  #   # puts "------------Package Discount-------------"
  #   # puts "----------------------------------------"
  #   # puts package_discount.as_json
  #   # puts "----------------------------------------"
  #   return package_discount
  # end

  # def bogo_discount(all_discounts)
  #   bogo_discount = DiscountBsgsGetItem.where(discount_id: all_discounts.pluck, catalog_id: self.catalog_id, active: true)
  #   # puts "------------Buy One Get One Discount-------------"
  #   # puts "----------------------------------------"
  #   # puts bogo_discount.as_json
  #   # puts "----------------------------------------"
  #   return bogo_discount
  # end

  # def calculate_discount
  #   puts "HERO"
  #   puts self.promocode
  #   catalog = Catalog.includes(:group).find(self.catalog_id)
  #   pricing = Pricing.find(catalog.pricing_id)
  #   all_discounts = pricing.discounts.where(:is_automatic => true)
  #   # puts "call-item-discount"
  #   all_discount_apply = Array.new
  #   minimum_hash = Hash.new
  #   # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  #   for_item_discount = self.item_discount(all_discounts)
  #   for_group_discount = self.group_discount(all_discounts)
  #   for_package_discount = self.package_discount(all_discounts)
  #   for_bogo_discount = self.bogo_discount(all_discounts)

  #   if for_item_discount.present?
  #     for_item_discount.each do |for_item_discount|
  #       item_discount_applicable = all_discounts.find(for_item_discount.discount_id)
  #       discount_offer_type = item_discount_applicable.discount_offer_type
  #       discount_offer = DiscountOffer.find(discount_offer_type.discount_offer_id)
  #       if discount_offer.value == "C" #(each item free)
  #         price = 0
  #       elsif discount_offer.value == "A" #(off each selected item)
  #         catalog_price = catalog.price
  #         discount_value = item_discount_applicable.value
  #         new_price = catalog_price - discount_value
  #         new_price < 0 ? price = 0 : price = new_price
  #       elsif discount_offer.value == "E" #(Percentage off on each item)
  #         catalog_price = catalog.price
  #         discount_value = item_discount_applicable.value
  #         discounted_percentage_price = (discount_value/100) * catalog_price
  #         new_price = catalog_price - discounted_percentage_price
  #         new_price < 0 ? price = 0 : price = new_price
  #       elsif discount_offer.value == "B" #(for_each_item; Each_item_for; total off)
  #         catalog_price = catalog.price
  #         discount_value = item_discount_applicable.value
  #         price = discount_value
  #       end
  #       # minimum_hash["#{item_discount_applicable.id}"] << price
  #       minimum_hash["#{item_discount_applicable.id}"] = price

  #       # minimum_hash.merge({"#{item_discount_applicable.id}": price})

  #       # puts minimum_hash
  #       # puts "**************Item*******New Price: #{price}********************"
  #     end
  #     all_discount_apply << for_item_discount.as_json
  #     # puts all_discount_apply
  #   end

  #   if for_group_discount.present?
  #     for_group_discount.each do |for_group_discount|
  #       group_discount_applicable = all_discounts.find(for_group_discount.discount_id)
  #       discount_offer_type = group_discount_applicable.discount_offer_type
  #       discount_offer = DiscountOffer.find(discount_offer_type.discount_offer_id)
  #       if discount_offer.value == "A" #(off each item)
  #         catalog_price = catalog.price
  #         discount_value = group_discount_applicable.value
  #         new_price = catalog_price - discount_value
  #         new_price < 0 ? price = 0 : price = new_price
  #       elsif discount_offer.value == "E" #(Percentage off the total)
  #         catalog_price = catalog.price
  #         discount_value = group_discount_applicable.value
  #         discounted_percentage_price = (discount_value/100) * catalog_price
  #         new_price = catalog_price - discounted_percentage_price
  #         new_price < 0 ? price = 0 : price = new_price
  #       elsif discount_offer.value == "B" #(each item for)
  #         catalog_price = catalog.price
  #         discount_value = group_discount_applicable.value
  #         price = discount_value
  #       elsif discount_offer.value == "C" #(each item free)
  #         price = 0
  #       end
  #       # minimum_hash << price
  #       # minimum_hash.merge({"#{group_discount_applicable.id}" => price})
  #       minimum_hash["#{group_discount_applicable.id}"] = price

  #       # puts "************Group*********New Price: #{price}********************"
  #     end
  #     all_discount_apply << for_group_discount.as_json
  #   end

  #   if for_bogo_discount.present?
  #     for_bogo_discount.each do |for_bogo_discount|
  #       bogo_discount_applicable = all_discounts.find(for_bogo_discount.discount_id)
  #       discount_offer_type = bogo_discount_applicable.discount_offer_type
  #       discount_offer = DiscountOffer.find(discount_offer_type.discount_offer_id)
  #       if discount_offer.value == "B" #(off each item)
  #         catalog_price = catalog.price
  #         discount_value = bogo_discount_applicable.value
  #         new_price = catalog_price - discount_value
  #         new_price < 0 ? price = 0 : price = new_price
  #       elsif discount_offer.value == "E" #(Percentage off on each item)
  #         catalog_price = catalog.price
  #         discount_value = bogo_discount_applicable.value
  #         discounted_percentage_price = (discount_value/100) * catalog_price
  #         new_price = catalog_price - discounted_percentage_price
  #         new_price < 0 ? price = 0 : price = new_price
  #       elsif discount_offer.value == "C" #(each item free)
  #         price = 0
  #       end
  #       # minimum_hash << price
  #       # minimum_hash.merge({"#{bogo_discount_applicable.id}" => price})
  #       minimum_hash["#{bogo_discount_applicable.id}"] = price

  #       # puts "**************Item*******New Price: #{price}********************"
  #     end

  #     all_discount_apply << for_bogo_discount.as_json
  #     # puts all_discount_apply
  #   end

  #   if for_package_discount.present?
  #     for_package_discount.each do |for_package_discount|
  #       package_discount = for_package_discount.package_discount
  #       package_discount_applicable = all_discounts.find(package_discount.discount_id)
  #       catalog_price = catalog.price
  #       discount_price = package_discount_applicable.package_price
  #       if catalog_price <= discount_price
  #         price = 0
  #       end
  #       minimum_hash["#{for_package_discount.id}"] = price
  #     end
  #     all_discount_apply << for_package_discount.as_json
  #   end

  #   minimum_price = Hash[minimum_hash.sort_by{|k, v| v}].first
  #   return all_discount_apply, minimum_price
  # end


  def self.to_csv(line_items1)
    attributes = %w{Quantity Revenue Item}
    CSV.generate(headers: true) do |csv|
      csv.add_row attributes
        all.each do |line_item|
          csv.add_row [line_items1.joins(:catalog).where('line_items.catalog_id = ?',line_item.catalog_id).count,line_items1.joins(:catalog).where('line_items.catalog_id = ?',line_item.catalog_id).sum('quantity') * line_item.catalog.price,"#{line_item.catalog.print_size_one}x#{line_item.catalog.print_size_two} #{line_item.catalog.sub_item_name} (#{line_item.catalog.group.name})"]
        end
    end
  end

  def line_item_details
  end
end
