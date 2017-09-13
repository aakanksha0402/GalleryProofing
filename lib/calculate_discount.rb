module CalculateDiscount

  def discount(cart,gallery = nil,promo = nil)

  #  logger.warn cart
    @cart = cart
    @promo = @cart.used_promocodes.all.pluck(:promocode)
    puts "++++++++++++++++++#{@promo.present?}++++++++++=="

    unless @promo.present?
      return nil
    end

    if gallery.present?
      gallery_of_discount = Gallery.find(gallery)

      if gallery_of_discount.custom_gallery_layout.pricing.present?
        if @promo.present? && gallery_of_discount.custom_gallery_layout.pricing.discounts.where(promocode:  @promo).present?
          bogo_alldiscount = gallery_of_discount.custom_gallery_layout.pricing.discounts.where('(promocode IN (?) AND (bogo_buy_qty is NOT NULL OR bogo_get_qty is NOT NULL)) OR is_automatic = true AND (bogo_buy_qty is NOT NULL OR bogo_get_qty is NOT NULL) ',@promo)
        else
          bogo_alldiscount = gallery_of_discount.custom_gallery_layout.pricing.discounts.where('is_automatic = true AND (bogo_buy_qty is NOT NULL OR bogo_get_qty is NOT NULL)')
        end
      else
        bogo_alldiscount = nil
      end

      discount_type = DiscountType.where(type_name: "Cart").first
      discount_offer_types = DiscountOfferType.where(discount_type_id: discount_type.id).pluck(:id)
      if @promo.present? && gallery_of_discount.custom_gallery_layout.pricing.present?
          if @promo.present? && gallery_of_discount.custom_gallery_layout.pricing.discounts.where(promocode:  @promo).present?
            cart_alldiscount = gallery_of_discount.custom_gallery_layout.pricing.discounts.where('(discount_offer_type_id IN (?) AND (promocode IN (?) OR is_automatic = true ) )',discount_offer_types,@promo)
          else
            cart_alldiscount = gallery_of_discount.custom_gallery_layout.pricing.discounts.where(discount_offer_type_id: discount_offer_types,is_automatic: true)
          end
      else
          cart_alldiscount = 0
      end

      total_cart_discount = 0
      package_discount_type = DiscountType.where(type_name: "Package").first
      package_discount_offer_types = DiscountOfferType.where(discount_type_id: package_discount_type.id).pluck(:id)
      if @promo.present? && gallery_of_discount.custom_gallery_layout.pricing.discounts.where(:promocode => @promo).present?
        package_alldiscount = gallery_of_discount.custom_gallery_layout.pricing.discounts.where('(discount_offer_type_id IN (?) AND (promocode IN (?) OR is_automatic = true ) )',package_discount_offer_types,@promo)
      else
        package_alldiscount = gallery_of_discount.custom_gallery_layout.pricing.discounts.where(discount_offer_type_id: package_discount_offer_types,is_automatic: true)
      end
      credit_discount_type = DiscountType.where(type_name: "Credit").first
      credit_discount_offer_types = DiscountOfferType.where(discount_type_id: credit_discount_type.id).pluck(:id)
      if @promo.present? && gallery_of_discount.custom_gallery_layout.pricing.discounts.where(:promocode => @promo).present?
        credit_alldiscount = gallery_of_discount.custom_gallery_layout.pricing.discounts.where('(discount_offer_type_id IN (?) AND promocode IN (?) )',credit_discount_offer_types,@promo)
      end
    end
    discount_hash = Hash.new
    discount_hash["package"] = 0
    @cart.line_items.each do |line_item|
      catalog = Catalog.includes(:group).find(line_item.catalog_id)
      pricing = Pricing.find(catalog.pricing_id)
      if @promo.present? && pricing.discounts.where(promocode: @promo).present?
        all_discounts = pricing.discounts.where('promocode IN (?) OR is_automatic = true',@promo)
      else
        all_discounts = pricing.discounts.where(:is_automatic => true)
      end
      all_discount_apply = Array.new

      for_item_discount = item_discount(all_discounts,line_item.catalog_id)
      for_group_discount = group_discount(all_discounts,catalog.group_id)
      for_bogo_discount = bogo_discount(all_discounts,line_item.catalog_id)

      if for_item_discount.present?
        for_item_discount.each do |for_item_discount|
          item_discount_applicable = all_discounts.find(for_item_discount.discount_id)
          discount_offer_type = item_discount_applicable.discount_offer_type
          discount_offer = DiscountOffer.find(discount_offer_type.discount_offer_id)
          if line_item.quantity >= item_discount_applicable.quantity
            if discount_offer.value == "C" #(each item free)
              price = catalog.price
            elsif discount_offer.value == "A" #(off each selected item)
              catalog_price = catalog.price
              discount_value = item_discount_applicable.value
              new_price = catalog_price - discount_value
              new_price < 0 ? price = catalog_price : price = discount_value
            elsif discount_offer.value == "E" #(Percentage off on each item)
              catalog_price = catalog.price
              discount_value = item_discount_applicable.value
              discounted_percentage_price = (discount_value/100) * catalog_price
              new_price = catalog_price - discounted_percentage_price
              new_price < 0 ? price = catalog_price : price = discounted_percentage_price
            elsif discount_offer.value == "B" #(for_each_item; Each_item_for; total off)
              catalog_price = catalog.price
              discount_value = item_discount_applicable.value
              catalog_price < discount_value ? price = catalog_price - discount_value : price = discount_value - catalog_price
            end
          end

          if price.present?
            if discount_hash["#{line_item.id}"].present? && discount_hash["#{line_item.id}"] <= price
             discount_hash["#{line_item.id}"] = price
            elsif !discount_hash["#{line_item.id}"].present?
              discount_hash["#{line_item.id}"] = price
            end
          end

        end
      end

      if for_group_discount.present?
        for_group_discount.each do |for_group_discount|
          group_discount_applicable = all_discounts.find(for_group_discount.discount_id)
          discount_offer_type = group_discount_applicable.discount_offer_type
          discount_offer = DiscountOffer.find(discount_offer_type.discount_offer_id)
          if line_item.quantity >= group_discount_applicable.quantity
            if discount_offer.value == "A" #(off each item)
              catalog_price = catalog.price
              discount_value = group_discount_applicable.value
              new_price = catalog_price - discount_value
              new_price < 0 ? price = catalog_price : price = discount_value
            elsif discount_offer.value == "E" #(Percentage off the total)
              catalog_price = catalog.price
              discount_value = group_discount_applicable.value
              discounted_percentage_price = (discount_value/100) * catalog_price
              new_price = catalog_price - discounted_percentage_price
                new_price < 0 ? price = catalog_price : price = discounted_percentage_price
            elsif discount_offer.value == "B" #(each item for)
              catalog_price = catalog.price
              discount_value = group_discount_applicable.value
              catalog_price < discount_value ? price = catalog_price - discount_value : price = discount_value - catalog_price
            elsif discount_offer.value == "C" #(each item free)
              price = catalog.price
            end
          end
          if price.present?
            if discount_hash["#{line_item.id}"].present? && discount_hash["#{line_item.id}"] <= price
             discount_hash["#{line_item.id}"] = price
            elsif !discount_hash["#{line_item.id}"].present?
              discount_hash["#{line_item.id}"] = price
            end
          end
        end
      end
    end
    if bogo_alldiscount.present?
        bogo_alldiscount.each do |bogo_discount|
          bogo_buy = DiscountBsgsBuyItem.where(discount_id: bogo_discount.id,active: true)
          applicable_bogo = true
          bogo_buy.each do |buy|
            bogo_line_item = LineItem.where(cart_id: @cart.id,catalog_id: buy.catalog_id , quantity: bogo_discount.bogo_buy_qty)
            if !bogo_line_item.present?
              applicable_bogo = false
            end
          end
          if applicable_bogo
            bogo_get = DiscountBsgsGetItem.where(discount_id: bogo_discount.id,active: true)
            bogo_get.each do |get|
              bogo_get_line_item = LineItem.where(cart_id: @cart.id,catalog_id: get.catalog_id , quantity: bogo_discount.bogo_get_qty).first
              if bogo_get_line_item.present?
                catalog_bogo_price = bogo_get_line_item.catalog.price
                discount_offer_type = bogo_discount.discount_offer_type
                discount_offer = DiscountOffer.find(discount_offer_type.discount_offer_id)
                if discount_offer.value == "B" #(off each item)
                  discount_value = bogo_discount.value
                  new_price = catalog_bogo_price - discount_value
                  new_price < 0 ? price = catalog_bogo_price : price = discount_value
                elsif discount_offer.value == "E" #(Percentage off on each item)y
                  discount_value = bogo_discount.value
                  discounted_percentage_price = (discount_value/100) * catalog_bogo_price
                  new_price = catalog_bogo_price - discounted_percentage_price
                  new_price < 0 ? price = catalog_bogo_price : price = discounted_percentage_price
                elsif discount_offer.value == "C" #(each item free)
                  price = catalog_bogo_price
                end
                if price.present?
                  if discount_hash["#{bogo_get_line_item.id}"].present? && discount_hash["#{bogo_get_line_item.id}"] <= price
                   discount_hash["#{bogo_get_line_item.id}"] = price
                  elsif !discount_hash["#{bogo_get_line_item.id}"].present?
                    discount_hash["#{bogo_get_line_item.id}"] = price
                  end
                end
              end
            end
          end
        end
    end
    if package_alldiscount.present?
      package_alldiscount.each do |package_discount|
        package_discount.package_discounts.each do |p_discount|
          count_item = 0
          p_discount.package_discount_items.each do |each_item|
            line_item = @cart.line_items.where(catalog_id: each_item.catalog_id).first
            if line_item.present? # && line_item.quantity == p_discount.package_qty
              count_item += line_item.quantity
            end
          end
          if count_item >= p_discount.package_qty
            discount_hash["package"] += package_discount.package_price
          end
        end
      end
    end
    if cart_alldiscount.present?
        cart_total_price = 0
        @cart.line_items.each do |line_item|
          if line_item.catalog.price  != 0
            cart_total_price += line_item.catalog.price
          else
            line_item.catalog.digital_media_prices.each do |sub_digital|
              if line_item.from == "2"
                cart_total_price += sub_digital.indiviual_photo_price
              else
                cart_total_price += sub_digital.all_gallery_photo_price
              end
            end
          end
        end


        cart_alldiscount.each do |cart_discount|
          count_discount = 0
          discount_cart_values = DiscountCartValue.where(discount_id: cart_discount.id)
          discount_cart_values.each do |val|
            if cart_total_price.between? val.from_value, val.to_value
              if val.percentage_value.present?
                count_discount += (val.percentage_value/100) * cart_total_price
              elsif val.dollar_value.present?
                count_discount += val.dollar_value
              end
            end
          end
          if count_discount > total_cart_discount
            total_cart_discount = count_discount
          end
        end
      end

    total_discount_amount = 0
    if discount_hash.present?
      discount_hash.each do |key,value|
        total_discount_amount += value
      end
    end
    puts total_discount_amount - total_cart_discount
    diff_total_package = total_discount_amount - discount_hash["package"]
    diff_discount = total_discount_amount - total_cart_discount
    diff_cart_package = discount_hash["package"] - total_cart_discount
    if diff_discount < 0 && diff_cart_package < 0
      discount_hash = {}
      discount_hash["cart"] = total_cart_discount
    elsif diff_total_package < 0
      temp = discount_hash["package"]
      discount_hash = {}
      discount_hash["package"] = temp
    end
    if discount_hash["package"] == 0
      discount_hash.delete("package")
    end
    if credit_alldiscount.present?
        heighest_credit_discount = 0
        credit_alldiscount.each do |credit|
          if credit.value > heighest_credit_discount
            heighest_credit_discount = credit.value
          end
        end
        discount_hash["credit"] = heighest_credit_discount
      end
    return discount_hash
  end

  private
  def item_discount(all_discounts,catalog_id)
      all_discounts = all_discounts
      item_discount = DiscountItemsList.where(discount_id: all_discounts.pluck, catalog_id: catalog_id, active: true)
      return item_discount
    end

    def group_discount(all_discounts,group_id)
      group = Group.find(group_id)
      group_discount = DiscountGroupsList.where(discount_id: all_discounts.pluck, group_id: group.id, active: true)
      return group_discount
    end
    def bogo_discount(all_discounts,catalog_id)
      bogo_discount = DiscountBsgsGetItem.where(discount_id: all_discounts.pluck, catalog_id: catalog_id,  active: true)
      return bogo_discount
    end
end
