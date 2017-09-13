class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :show_group


  @@variable=1
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  def rename_group
    puts params
    @rename=Group.find_by(id: params[:div_val].to_i).update(rename: params[:group][:name])
    redirect_to show_group_groups_path(id: params[:pricing_id])
  end

  # GET /groups/new
  def new
    @group = Group.new
    count
  end

  # GET /groups/1/edit
  def edit
  end


  def update_custom_item
    puts params



    if params[:fix_group_id].present?
      puts "if"
      @custom_items = Catalog.find_by(id: params[:id])
      @digital_media_price=DigitalMediaPrice.find(params[:id])

      #enabling and diabling the individual photo price
      if params[:individual_price_active].present?
        if params[:individual_price_active] == "true"
          puts "ipa_true"
          @digital_media_price.update(individual_price_active: false)
        else
          puts "ipa_false"
          @digital_media_price.update(individual_price_active: true)
        end
      end
      #enabling and diabling the all album photo price
      if params[:all_album_price_active].present?
        if params[:all_album_price_active] == "true"
          puts "album_true"
          @digital_media_price.update(all_album_price_active: false)
        else
          puts "album_false"
          @digital_media_price.update(all_album_price_active: true)
        end
      end
      #enabling and diabling the all gallery photo price
      if params[:all_gallery_price_active].present?
        if params[:all_gallery_price_active] == "true"
          puts "gallery_true"
          @digital_media_price.update(all_gallery_price_active: false)
        else
          puts "gallery_false"
          @digital_media_price.update(all_gallery_price_active: true)
        end
      end
      #updating the resolution of custom item of digital media group in catalog
      if params[:resolution].present?
        @custom_items.update(resolution: params[:resolution])
      end
      if params[:indiviual_price].present?
        @digital_media_price.update(individual_photo_price: params[:indiviual_price])
      end

    else
      puts "else"
      puts params

      @custom_items = Catalog.find_by(id: params[:id])

      #updating the prices of custom items of the digital group
      @digital_media_price = DigitalMediaPrice.all
      if params[:individual_photo_price].present?
        @digital_media_price.find(params[:id]).update(indiviual_photo_price: params[:individual_photo_price],all_album_photo_price: params[:all_album_photo_price],all_gallery_photo_price: params[:all_gallery_photo_price])
      end
      if params[:individual_price_active].present?
        @digital_media_price.find(params[:id]).update(individual_price_active: params[:individual_price_active])
      end
      if params[:all_album_price_active].present?
        @digital_media_price.find(params[:id]).update(all_album_price_active: params[:all_album_price_active])
      end
      if params[:all_gallery_price_active].present?
        @digital_media_price.find(params[:id]).update(all_gallery_price_active: params[:all_gallery_price_active])
      end
      #updating the item name of the catalog
      if params[:d].present?
        @custom_items.update(sub_item_name: params[:d])
      end
      #updating the price of the items in  catalog
      if params[:price].present?
        @custom_items.update(price: params[:price])
      end
      #updating the shipping charges of the items in catalogs
      if params[:shipping_charge].present?
        @custom_items.update(shipping_charge: params[:shipping_charge])
      end

      if params[:sales_tax_per].present?
        @sales_tax = SalesTax.find(params[:id])
        puts "present"
        puts params[:digital_tax_charge]
        if params[:sales_tax_state_id] == ""
          @sales_tax.update(tax_percent: params[:sales_tax_per],title: params[:sales_tax_title],vat: params[:sales_tax_vat],state_id: 0)
        else
          @sales_tax.update(tax_percent: params[:sales_tax_per],title: params[:sales_tax_title],vat: params[:sales_tax_vat],state_id: params[:sales_tax_state_id])
        end
        if params[:digital_tax_charge] == "true"
          @sales_tax.update(digital_charge: false);
        else
          @sales_tax.update(digital_charge: true);
        end
        if params[:shipping_tax] == "true"
          @sales_tax.update(shipping_tax: false);
        else
          @sales_tax.update(shipping_tax: true);
        end
      end

      #updating the title of shipping of pricesheet
      if params[:shipping_title].present?
        @shipping = Shipping.find(params[:id])
        @shipping.update(title: params[:shipping_title],shipping_option_price: params[:shipping_option_price],shipping_option_title: params[:shipping_option_title])
      end

    end
  end

  def find_records
    puts params
    # puts find_record.as_json
    # @@variable=find_record
    @found_records=Catalog.where(pricing_id: params[:id]).all
    @@variable=params[:group_id]
    puts "________________"
    puts @@variable
    redirect_to root_path(test_params: params[:group_id])
    # redirect_to self_fulfillment_groups_path(id: params[:id],group: 1)
  end
  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        format.html { redirect_to show_group_groups_path(id: @group.pricing_id), notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to show_group_groups_path(id: @group.pricing_id), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    if @group.is_deleted?
      respond_to do |format|
        format.html { redirect_to show_group_groups_path(id: @group.pricing_id), notice: 'This group cannot be deleted. The groups for Prints, Canvases, Metals, Products and Digital Media cannot be deleted.' }
        format.json { head :no_content }
      end
    else
      @group.destroy
      respond_to do |format|
        format.html { redirect_to show_group_groups_path(id: @group.pricing_id), notice: 'Group was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def delete_group
    puts params
    @is_deleted=Group.find_by(id: params[:div_val1]).update(is_deleted: true)
    redirect_to show_group_groups_path(id: params[:pricing_id])
  end

  def show_group

    @catalog = Catalog.new
    @resolution = ItemList.all
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
    @groups = Group.where(pricing_id: params[:id])
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

  def show_group1
    @catalog = Catalog.new
    @resolution = ItemList.all
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
    @groups = Group.where(pricing_id: params[:id])
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

  # def test_page
  #   @display_list_items = Catalog.where("pricing_id = ? AND checked = ?", params[:id], true).order(print_size_one: :asc)
  #   @display_list_items1 = Catalog.where("pricing_id = ? AND checked = ?", params[:id], true)
  #   @array = @display_list_items1.uniq.pluck(:item_list_id)
  #   @resolution = ItemList.all
  #   @fixed_tab = Group.where("fix_group_id IS NOT ? AND pricing_id = ?",nil,params[:id]).order(id: :asc)
  #   @count = count
  #   @pricing_group_name = Pricing.find_by(id: params[:id])
  # end

  def self_fulfillment
    @found_records = Catalog.where(pricing_id: params[:id]).all
    @fix_groups = Group.where(pricing_id: params[:id]).all
    @pricings = Pricing.find_by(id: params[:id])
    @abc = Group.where(pricing_id: params[:id])
    @resolution=ItemList.all
    @catalog_items =Catalog.where(pricing_id: params[:id])
    # if params[:type] == "self"
      @default_pricing_items = Catalog.where("pricing_id = ?", params[:id]).all.order(id: :asc)
    # else
    #   @default_pricing_items = Catalog.where("pricing_id = ? AND cost IS NOT ?", params[:id],nil).all.order(id: :asc)
    # end
    puts "_______"
    puts @default_pricing_items.ids
    @count = count
    @count_prints_checked = Catalog.where("pricing_id = ? AND checked = ? AND fix_group_id = ?",params[:id],true,1)
    @count_canvases_checked = Catalog.where("pricing_id = ? AND checked = ? AND fix_group_id = ?",params[:id],true,3)
    @count_canvases_checked1 = Catalog.where("pricing_id = ? AND fix_group_id = ?",params[:id],params[:group])
    @group_list = Catalog.uniq.pluck(:group_id)
    @fgi = Catalog.uniq.pluck(:fix_group_id)
  end
  def update_selffulfillment
    puts params[:task_ids]
    @catalog = Catalog.where(["id NOT IN (?)",params[:task_ids]])
    @already_true = @catalog.where(checked: true);
    puts @already_true.as_json
    # @discount=Discount.find_by(pricing_id: params[:id])
    # if @discount.present?
    #   puts "Hello"
    #   @discountItemsList=DiscountItemsList.where(discount_id: @discount.id).uniq.pluck(:catalog_id)
    #   puts @discountItemsList.class
    # end

    puts params[:task_ids].size
    Catalog.where(["id NOT IN (?) AND fix_group_id IN (?)",params[:task_ids],[1,3]]).update_all(checked: false)
    @already_true1 = Catalog.where(id: @already_true.map(&:id))
    puts @already_true1.as_json
    Catalog.where(id: params[:task_ids]).update_all(checked: true)
    # params[:task_ids].each do |task_id|
    #   Catalog.find(task_id).update(checked: true)
    #   if @discount.present?
    #     unless @discountItemsList.include?task_id
    #       @new_discount_item = DiscountItemsList.new(catalog_id: task_id,active: true,discount_id: @discount.id)
    #       @new_discount_item.save
    #     end
    #   end
    # end
    redirect_to show_group_groups_url(id: params[:id])
  end

  def delete_item
    puts params
    @deleted_item=Catalog.find_by(id: params[:delete_item_id]).update(checked: false)
    redirect_to show_group_groups_url(id: params[:pricing_id])
  end
  def add_description
    puts params
    @item_description=Catalog.find_by(id: params[:item_description_id]).update(discription: params[:catalog][:discription])
    redirect_to show_group_groups_url(id: params[:pricing_id])
  end
  def add_terms_of_sale
    puts params
    @shipping=Shipping.find_by(pricing_id: params[:shipping][:pricing_id])
    @shipping.update(terms_of_sales: params[:shipping][:terms_of_sales])
    redirect_to show_group_groups_url(id: params[:shipping][:pricing_id])
    # redirect_to root_path
  end

  def update_shipping_details
    puts params
    @shipping = Shipping.find_by(id: params[:id]).update(title: params[:shipping_title])
    redirect_to show_group_groups_path(id: @shipping.pricing_id)
  end

  def adding_shipping_option
    puts params
    @shipping_option=ShippingOption.where(shipping_id: params[:id])
    puts "____________"
    @shipping_option.destroy_all
    @prices_array=[]
    @titles_array=[]
    params[:prices].split(",").each do |price|
      @prices_array << price
    end
    params[:titles].split(",").each do |title|
      @titles_array << title
    end
    @prices_array.zip(@titles_array).each do |zip|
      @shipping_option = ShippingOption.new(title: zip[1],price: zip[0],shipping_id: params[:id])
      @shipping_option.save
    end
    redirect_to root_path
  end
  def delete_shipping_option
    puts params
    @shipping_option=ShippingOption.find(params[:delete_item_id])
    @shipping_option.destroy
    redirect_to show_group_groups_path(id: params[:id])
  end

  def print
    @pricing = Pricing.find_by(id: params[:price_sheet_id])
    @catalog_items = Catalog.where(pricing_id: @pricing.id,checked: true)
    @groups = Group.where(pricing_id: @pricing.id)
    @pricing_groups = @catalog_items.uniq.pluck(:group_id)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end
    def count
      @groups = Group.where(pricing_id: params[:id])
      @count = Group.where(fix_group_id: nil, pricing_id: params[:id]).count
      @remaning = 3- @count
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:fix_group_id, :name, :is_deleted, :pricing_id,:rename)
    end

    def find_record
      @found_records=Catalog.where(pricing_id: params[:id], fix_group_id: params[:group_id]).all
    end
end
