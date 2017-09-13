class PricingsController < ApplicationController
  before_action :set_pricing, only: [:show, :edit, :update, :destroy, :duplicate_pricesheet]

  # GET /pricings
  # GET /pricings.json
  def index
    if @current_user_permissions.find_by(permission_name: "View Pricing").value == false
      @not_authorized = true
    end
    @pricings = current_user.pricings.where(is_deleted: false).order(name: :asc)
    @pricing = Pricing.new
    @labs=CountryLab.where(country_id: current_brand.brand_country)
    @lab=Lab.where(id: @labs.map(&:lab_id)).to_a
    @pricing_style=PricingStyle.where(lab_id: nil)
    @pricing_style1=PricingStyle.where(lab_id: @labs.map(&:lab_id)).to_a
    @labs_pricing_style = @pricing_style1 | @pricing_style

    @galleries = current_brand.galleries.all
    @custom_gallery_layout = CustomGalleryLayout.all
    @default_gallery_layout = GalleryLayout.all


  end

  # GET /pricings/1
  # GET /pricings/1.json
  def show
  end

  # GET /pricings/new
  def new
    @pricing = Pricing.new
  end

  # GET /pricings/1/edit
  def edit
    @groups = Group.where(pricing_id: @pricing.id)
    @catalogs = @groups.first.catalogs.where(checked: true)

    @categories = Catalog.where(:group_id => @groups.first , :checked => true).group_by{|x| x.print_size_one || x.print_size_two }
    @catalog = Catalog.new
    @resolution = ItemList.all
    # group =  Pricing.first.groups.first
    @display_list_items = Catalog.where("pricing_id = ? AND checked = ?", params[:id], true).order(print_size_one: :asc)
    @display_list_items1 = Catalog.where("pricing_id = ? AND checked = ?", params[:id], true)
    puts "_________________"
    puts @display_list_items1.ids
    puts "_________________"
    @array = @display_list_items1.uniq.pluck(:item_list_id)
    @array1 = @display_list_items1.where(catalog_type: 'Custom').uniq.pluck(:id)
    @fixed_tab = Group.where("fix_group_id IS NOT ? AND pricing_id = ?",nil,params[:id]).order(id: :asc)
    @added_group = Group.where("fix_group_id IS ? AND pricing_id = ? AND is_deleted = ?",nil,params[:id],false)
    @added_group1 = Group.where("fix_group_id IS ? AND pricing_id = ?",nil,params[:id])
    @merge = @fixed_tab | @added_group
    @group = Group.new

    @group_name = Pricing.find_by(id: params[:id])
    @default_pricing_items = Catalog.where(pricing_id: params[:id], fix_group_id: 1).all
    @count = count
    @pricesheet_rename = Pricing.find_by(id: params[:id])
    puts "_______________"
    puts @display_list_items.ids
    puts "_______________"
    @digital_media_price = DigitalMediaPrice.where(catalog_id: @display_list_items.map(&:id))
    puts "****************"
    puts @digital_media_price.as_json
    puts "****************"
    @digital_media_price_array = @digital_media_price.uniq.pluck(:id)
    puts "__________"
    puts @digital_media_price_array.as_json

    @sales_tax = SalesTax.find_by(pricing_id: params[:id])

    @shipping = Shipping.find_by(pricing_id: params[:id])

    @shipping_option = ShippingOption.where(shipping_id: @shipping.id)

    @state = StateProvince.where(country_id: current_brand.brand_country)


    respond_to do |format|
      format.html
      format.js
    end
  end

  def digital_media
    puts "----------------------"
    puts "hello"
    puts "----------------------"
    @categories = Catalog.where(:group_id => params[:group_id] , :checked => true).group_by{|x| x.print_size_one || x.print_size_two }

  end

  # POST /pricings
  # POST /pricings.json
  def create
    puts params
    @pricing = Pricing.new(pricing_params)
    @pricing.is_deleted = false
    puts @pricing.save
    respond_to do |format|
      if @pricing.save
        @fix_group = FixGroup.all
        @fix_group.each do |f|
          @group = Group.new(fix_group_id: f.id, name: f.name ,is_deleted: false,pricing_id: @pricing.id)
          @group.save
        end
        @prints_item = ItemList.includes(:sub_items).all
        if params[:pricing][:pricing_style_id].to_i != 2
        @prints_item.each do |item|
          @grp = Group.find_by("fix_group_id = ? AND pricing_id = ? ",item.fix_group_id,@pricing.id)
          item.sub_items.each do |sub_item|
            if [8,11].include? item.id
              if params[:pricing][:pricing_style_id].to_i > 2
                @catalog = Catalog.new(pricing_id: @pricing.id,group_id: @grp.id,fix_group_id: item.fix_group_id,print_size_one: item.size_one,print_size_two: item.size_two,depth: item.depth,sub_item_name: sub_item.name,item_list_id: item.id,checked: true,cost: 0.00,price: 0.00)
                @catalog.save
                @catalog = Catalog.new(pricing_id: @pricing.id,group_id: @grp.id,fix_group_id: item.fix_group_id,print_size_one: item.size_one,print_size_two: item.size_two,depth: item.depth,sub_item_name: sub_item.name,item_list_id: item.id,checked: true)
                @catalog.save
              else
                @catalog = Catalog.new(pricing_id: @pricing.id,group_id: @grp.id,fix_group_id: item.fix_group_id,print_size_one: item.size_one,print_size_two: item.size_two,depth: item.depth,sub_item_name: sub_item.name,item_list_id: item.id,checked: true)
                @catalog.save
              end
            else
              if params[:pricing][:pricing_style_id].to_i > 2
                @catalog = Catalog.new(pricing_id: @pricing.id,group_id: @grp.id,fix_group_id: item.fix_group_id,print_size_one: item.size_one,print_size_two: item.size_two,depth: item.depth,sub_item_name: sub_item.name,item_list_id: item.id,cost: 0.00,price: 0.00)
                @catalog.save
                @catalog = Catalog.new(pricing_id: @pricing.id,group_id: @grp.id,fix_group_id: item.fix_group_id,print_size_one: item.size_one,print_size_two: item.size_two,depth: item.depth,sub_item_name: sub_item.name,item_list_id: item.id)
                @catalog.save
              else
                @catalog = Catalog.new(pricing_id: @pricing.id,group_id: @grp.id,fix_group_id: item.fix_group_id,print_size_one: item.size_one,print_size_two: item.size_two,depth: item.depth,sub_item_name: sub_item.name,item_list_id: item.id)
                @catalog.save
              end
            end
            # @catalog.save
          end
        end
        # puts "GROUP COUNT:"
        # puts @grp.id

        @catalog_digital_media=Catalog.new(pricing_id: @pricing.id,group_id: Group.find_by(pricing_id: @pricing.id,fix_group_id: 2).id,fix_group_id: 2,sub_item_name: "Full Resolution",is_default: true,checked: true,is_galleryproofing: true)
        @catalog_digital_media.save
        puts @catalog_digital_media.id
        @default_digital_media_prices=DigitalMediaPrice.new(indiviual_photo_price: 0.00,individual_price_active: false,all_album_photo_price: 0.00, all_album_price_active: false,all_gallery_photo_price: 0.00,all_gallery_price_active: false,catalog_id: @catalog_digital_media.id)
        @default_digital_media_prices.save
      else
        @prints_item.each do |item|
          @grp = Group.find_by("fix_group_id = ? AND pricing_id = ? ",item.fix_group_id,@pricing.id)
          item.sub_items.each do |sub_item|
            @catalog = Catalog.new(pricing_id: @pricing.id,group_id: @grp.id,fix_group_id: item.fix_group_id,print_size_one: item.size_one,print_size_two: item.size_two,depth: item.depth,sub_item_name: sub_item.name,item_list_id: item.id)
            @catalog.save
          end
        end
      end
        @sales_tax = SalesTax.new(pricing_id: @pricing.id)
        @sales_tax.save
        @shipping = Shipping.new(pricing_id: @pricing.id)
        @shipping.save

        format.html { redirect_to pricings_path(id: current_user.id), notice: 'Pricing was successfully created.' }
        format.json { render :show, status: :created, location: @pricing }
      else
        if params[:pricing][:pricing_style_id] == "" && params[:pricing][:name] == ""
          format.html { redirect_to pricings_path, flash: {errorforall: 'Color logo name could not be created'} }
          format.json { render json: @color_logo.errors, status: :unprocessable_entity }
        elsif params[:pricing][:pricing_style_id] == ""
          format.html { redirect_to pricings_path, flash: {errorforpricingstyle: 'Color logo name could not be created'} }
          format.json { render json: @color_logo.errors, status: :unprocessable_entity }
        elsif params[:pricing][:name] == ""
          format.html { redirect_to pricings_path, flash: {errorforname: 'Color logo name could not be created'} }
          format.json { render json: @color_logo.errors, status: :unprocessable_entity }
        else
          format.html { render :new }
          format.json { render json: @pricing.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /pricings/1
  # PATCH/PUT /pricings/1.json
  def update
    respond_to do |format|
      if @pricing.update(pricing_params)
        format.html { redirect_to show_group_groups_path(id: params[:id]), notice: 'Pricing was successfully updated.' }
        format.json { render :show, status: :ok, location: @pricing }
      else
        format.html { render :edit }
        format.json { render json: @pricing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pricings/1
  # DELETE /pricings/1.json
  def destroy
    # @pricing.update(is_deleted: true)
    @custom_gallery_layout = CustomGalleryLayout.where(pricing_id: @pricing.id)
    @custom_gallery_layout.update_all(pricing_id: params[:new_pricesheet])
    @pricing.destroy
    respond_to do |format|
      format.html { redirect_to pricings_path(id: current_user.id), notice: 'Pricing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def duplicate_pricesheet
    puts params
    puts @pricing.as_json
    @duplicate_pricing = @pricing.dup
    @duplicate_pricing.name = params[:duplicate_name]

    #Duplicating Price Sheet
    if @duplicate_pricing.save

      #Duplicating Group
      @groups = Group.where(pricing_id: @pricing.id)
      puts "_________________"
      puts @groups.as_json
      puts "_________________"
      @groups.each do |group|
        @duplicate_group = group.dup
        @duplicate_group.pricing_id = @duplicate_pricing.id
        @duplicate_group.save
        #Duplicating Catalog Items
        @catalogs = Catalog.where(pricing_id: @pricing.id,group_id: group.id)
        @catalogs.each do |catalog|
          @duplicate_catalog = catalog.dup
          @duplicate_catalog.pricing_id = @duplicate_pricing.id
          @duplicate_catalog.group_id = @duplicate_group.id
          @duplicate_catalog.save
        end
      end

      #Duplicating SalesTax
      @sales_tax = SalesTax.find_by(pricing_id: @pricing.id)
      puts "Sales Tax"
      puts @sales_tax.as_json
      puts "Duplicate Sales Tax"
      puts @duplicate_sales_tax.as_json
      @sales_tax
      @duplicate_sales_tax = @sales_tax.dup
      @duplicate_sales_tax.pricing_id = @duplicate_pricing.id
      @duplicate_sales_tax.save

      #Duplicating Shipping
      @shipping = Shipping.find_by(pricing_id: @pricing.id)
      @duplicate_shipping = @shipping.dup
      @duplicate_shipping.pricing_id = @duplicate_shipping.id
      @duplicate_shipping.save

      @shipping_options = ShippingOption.where(shipping_id: @shipping.id)
      @shipping_options.each do |shipping_option|
        @duplicate_shipping_option = shipping_option.dup
        @duplicate_shipping_option.shipping_id = @duplicate_shipping.id
        @duplicate_shipping_option.save
      end

      # Duplicating Discounts
      @discounts=Discount.where(pricing_id: @pricing.id)
      puts "_________________"
      puts @discounts.as_json
      puts "_________________"
      @discounts.each do |discount|
        @duplicate_discount = discount.dup
        @duplicate_discount.pricing_id = @duplicate_pricing.id
        @duplicate_discount.save

        #Duplicating DiscountItemsList
        @discount_items_list = DiscountItemsList.where(discount_id: discount.id)
        puts "_________________"
        puts @discount_items_list.as_json
        puts "_________________"
        @discount_items_list.each do |discount_item|
          @duplicate_discount_items_list = discount_item.dup
          @duplicate_discount_items_list.discount_id = @duplicate_discount.id
          @duplicate_discount_items_list.save
        end

        #Duplicating DiscountGroupsList
        @discount_groups_list =DiscountGroupsList.where(discount_id: discount.id)
        puts "_________________"
        puts @discount_groups_list.as_json
        puts "_________________"
        @discount_groups_list.each do |discount_group|
          @duplicate_discount_group_list = discount_group.dup
          @duplicate_discount_group_list.discount_id = @duplicate_discount.id
          @duplicate_discount_group_list.save
        end

        #Duplicating DiscountCartValue
        @discount_cart_values = DiscountCartValue.where(discount_id: discount.id)
        puts "_________________"
        puts @discount_cart_values.as_json
        puts "_________________"
        @discount_cart_values.each do |cart_value|
          @duplicate_discount_cart_value = cart_value.dup
          @duplicate_discount_cart_value.discount_id = @duplicate_discount.id
          @duplicate_discount_cart_value.save
        end

        #Duplicating DiscountBsgsBuyItem
        @discount_bsgs_buy_items = DiscountBsgsBuyItem.where(discount_id: discount.id)
        puts "_________________"
        puts @discount_bsgs_buy_items.as_json
        puts "_________________"
        @discount_bsgs_buy_items.each do |buy_item|
          @duplicate_discount_bsgs_buy_item = buy_item.dup
          @duplicate_discount_bsgs_buy_item.discount_id = @duplicate_discount.id
          @duplicate_discount_bsgs_buy_item.save
        end

        #Duplicating DiscountBsgsGetItem
        @discount_bsgs_get_items = DiscountBsgsGetItem.where(discount_id: discount.id)
        puts "_________________"
        puts @discount_bsgs_get_items.as_json
        puts "_________________"
        @discount_bsgs_get_items.each do |get_item|
          @duplicate_discount_bsgs_get_item = get_item.dup
          @duplicate_discount_bsgs_get_item.discount_id = @duplicate_discount.id
          @duplicate_discount_bsgs_get_item.save
        end

        #Duplicating PackageDiscount
        @package_discounts = PackageDiscount.where(discount_id: discount.id)
        puts "_________________"
        puts @package_discounts.as_json
        puts "_________________"
        @package_discounts.each do |package_discount|
          @duplicate_package_discount = package_discount.dup
          @duplicate_package_discount.discount_id = @duplicate_discount.id
          @duplicate_package_discount.save

          #Duplicating PackageDiscountItem
          @package_discount_items = PackageDiscountItem.where(package_discount_id: package_discount.id)
          puts "_________________"
          puts @package_discount_items.as_json
          puts "_________________"
          @package_discount_items.each do |package_discount_item|
            @duplicate_package_discount_item = package_discount_item.dup
            @duplicate_package_discount_item.package_discount_id = @duplicate_package_discount.id
            @duplicate_package_discount_item.save
          end
        end
      end
    end
    redirect_to pricings_path(id: current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pricing
      @pricing = Pricing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pricing_params
      params.require(:pricing).permit(:name, :is_deleted, :user_id, :pricing_style_id).merge(user_id: current_user.id)
    end

    def count
      @groups = Group.where(pricing_id: params[:id])
      @count = Group.where(fix_group_id: nil, pricing_id: params[:id]).count
      @remaning = 3- @count
    end
end
