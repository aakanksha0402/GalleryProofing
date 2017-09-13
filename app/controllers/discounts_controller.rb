class DiscountsController < ApplicationController
  before_action :set_discount, only: [:show, :edit, :update, :destroy]

  # GET /discounts
  # GET /discounts.json
  def index
    @discounts = Discount.where(pricing_id: params[:id]).order(id: :desc)
    @pricings=Pricing.find(params[:id])
    @discount_types=DiscountType.all
    @catalog_items=Catalog.where(pricing_id: params[:id],checked: true)
    @groups=Group.where(pricing_id: params[:id])
    @resolution=ItemList.all
    # puts @catalog_items.as_json
    @array=@catalog_items.uniq.pluck(:item_list_id)
    @array1=@catalog_items.where(catalog_type: 'Custom').uniq.pluck(:id)
    puts @array
    @list_item_id_array = @array.sort{|a,b| a && b ? a <=> b : a ? -1 : 1 }
    # puts @list_item_id_array
    @discount_offer_types=DiscountOfferType.all
    @discount=Discount.new
    @discount_offers=DiscountOffer.all
    @discount_items_lists=DiscountItemsList.all
    @discount_groups_list=DiscountGroupsList.all
    @discount_bsgs_buy_items=DiscountBsgsBuyItem.all
    @discount_bsgs_get_items=DiscountBsgsGetItem.all
    @discount_cart_values=DiscountCartValue.all
    @package_discounts=PackageDiscount.where(discount_id: @discount.id)
    @package_discount_items=PackageDiscountItem.all



  end

  # GET /discounts/1
  # GET /discounts/1.json
  def show
  end

  # GET /discounts/new
  def new
    @discount = Discount.new
  end

  # GET /discounts/1/edit
  def edit
  end

  # POST /discounts
  # POST /discounts.json
  def create
    @discount = Discount.new(discount_params)

    respond_to do |format|
      if @discount.save
        format.html { redirect_to @discount, notice: 'Discount was successfully created.' }
        format.json { render :show, status: :created, location: @discount }
      else
        format.html { render :new }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discounts/1
  # PATCH/PUT /discounts/1.json
  def update
    respond_to do |format|
      if @discount.update(discount_params)
        format.html { redirect_to @discount, notice: 'Discount was successfully updated.' }
        format.json { render :show, status: :ok, location: @discount }
      else
        format.html { render :edit }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_name
    if params[:discount][:name].present?
      Discount.find(params[:id]).update(name: params[:discount][:name])
    end
    if params[:discount][:description].present?
      Discount.find(params[:id]).update(description: params[:description])
    end
    puts params
    redirect_to discounts_path(id: params[:pricing_id])
  end

  # DELETE /discounts/1
  # DELETE /discounts/1.json
  def destroy
    @pricing_id=@discount.pricing_id
    @discount.destroy
    respond_to do |format|
      format.html { redirect_to discounts_url(id: @pricing_id), notice: 'Discount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def save_discount
    puts params


    @a=DiscountOfferType.where(discount_type_id: params[:discount_type_id])
    @count1=Discount.where(pricing_id: params[:id],discount_offer_type_id: @a.map(&:id))

    if params[:discount_type_name] == "Item"
      @discount_offer=DiscountOffer.find_by(value: params[:item_radio_option])
      puts @discount_offer.as_json
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id)
      puts @discount_offer_type.as_json
      @count=Discount.where(discount_offer_type_id: @discount_offer_type.id,pricing_id: params[:id])
      puts "!!!!!!!!!!!!!!!!!"
      puts @count1.count
      puts "!!!!!!!!!!!!!!!!!"
      if params[:item_radio_option] == "A"
        @value = params[:off_each_selected_item_value]
      elsif params[:item_radio_option] == "E"
        @value = params[:percent_off_each_item_value]
      elsif params[:item_radio_option] == "B"
        @value = params[:cost_for_each_item_value]
      else
        @value = ''
      end
      if params[:item_discount_type] == "Automatic"
        @item_discount=Discount.new(name: "Item"+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: true,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],value: @value,expiration_date: params[:promocode_expiration])
      else
        @item_discount=Discount.new(name: "Item"+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],value: @value,expiration_date: params[:promocode_expiration])
      end
      @item_discount.save
      @item_id=[]
      if params[:item_id].present?
        params[:item_id].each do |param1|
          @item_id << param1.to_i
        end
      end

      @catalog=Catalog.where(pricing_id: @item_discount.pricing_id,checked: true)
      @catalog.each do |catalog|
        if @item_id.include? catalog.id
          @discount_items_list=DiscountItemsList.new(catalog_id: catalog.id,active: true,discount_id: @item_discount.id)
        else
          @discount_items_list=DiscountItemsList.new(catalog_id: catalog.id,active: false,discount_id: @item_discount.id)
        end
        @discount_items_list.save
      end
    end

    if params[:discount_type_name] == "Group"
      @discount_offer=DiscountOffer.find_by(value: params[:group_radio_option])
      # puts @discount_offer.as_json
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])
      # puts @discount_offer_type.as_json
      @count=Discount.where(discount_offer_type_id: @discount_offer_type.id)
      puts @count.count
      if params[:group_radio_option] == "A"
        @value = params[:group_off_each_selected_item_value]
      elsif params[:group_radio_option] == "E"
        @value = params[:group_percent_off_each_item_value]
      elsif params[:group_radio_option] == "B"
        @value = params[:group_cost_for_each_item_value]
      else
        @value = ''
      end
      if params[:item_discount_type] == "Automatic"
        @group_discount=Discount.new(name: "Group"+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: true,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],value: @value)
      else
        @group_discount=Discount.new(name: "Group"+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],value: @value )
      end
      @group_discount.save
      @group_id=[]
      if params[:group_id].present?
        params[:group_id].each do |param1|
          @group_id << param1.to_i
        end
      end

      @catalog=Group.where(pricing_id: @group_discount.pricing_id)
      @catalog.each do |catalog|
        if @group_id.include? catalog.id
          @discount_groups_list=DiscountGroupsList.new(group_id: catalog.id,active: true,discount_id: @group_discount.id)
        else
          @discount_groups_list=DiscountGroupsList.new(group_id: catalog.id,active: false,discount_id: @group_discount.id)
        end
        @discount_groups_list.save
      end
    end

    if params[:discount_type_name] == "Credit"
      @discount_offer=DiscountOffer.find_by(value: params[:credit_radio_option])
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])
      @count=Discount.where(discount_offer_type_id: @discount_offer_type.id)
      puts @count.count
      if params[:credit_radio_option] == "A"
        @value = params[:credit_off_each_selected_item_value]
      else
        @value = -1
      end
      if params[:item_discount_type] == "Automatic"
        @credit_discount=Discount.new(name: "Credit"+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: true,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],value: @value)
      else
        @credit_discount=Discount.new(name: "Credit"+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],value: @value )
      end
      @credit_discount.save
    end

    if params[:discount_type_name] == "Cart"
      @discount_offer=DiscountOffer.find_by(value: params[:cart_radio_option])
      puts @discount_offer.as_json
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])
      puts @discount_offer_type.as_json
      @count=Discount.where(discount_offer_type_id: @discount_offer_type.id)
      if params[:item_discount_type] == "Automatic"
        @cart_discount=Discount.new(name: "Cart"+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: true,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],expiration_date: params[:promocode_expiration])
      else
        @cart_discount=Discount.new(name: "Cart"+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],expiration_date: params[:promocode_expiration])
      end
      @cart_discount.save
      @array_from_value=[]
      params[:From_Value].split(",") do |param_from|
        @array_from_value << param_from.to_i
      end
      @array_to_value=[]
      params[:To_Value].split(",") do |param_to|
        @array_to_value << param_to.to_i
      end
      if params[:cart_radio_option] == "E"
        @array_cart_percentage=[]
        params[:cart_percentage].split(",") do |param_cart_percentage|
          @array_cart_percentage << param_cart_percentage.to_i
        end
        @array_from_value.zip(@array_to_value,@array_cart_percentage) do |from_value,to_value,percent_value|
          @discount_cart_values=DiscountCartValue.new(discount_id: @cart_discount.id,from_value: from_value,to_value: to_value,percentage_value: percent_value)
          @discount_cart_values.save
        end
      end
      if params[:cart_radio_option] == "A"
        @array_cart_dollar=[]
        params[:cart_dollar].split(",") do |param_cart_dollar|
          @array_cart_dollar << param_cart_dollar.to_i
        end
        @array_from_value.zip(@array_to_value,@array_cart_dollar) do |from_value,to_value,dollar_value|
          @discount_cart_values=DiscountCartValue.new(discount_id: @cart_discount.id,from_value: from_value,to_value: to_value,dollar_value: dollar_value)
          @discount_cart_values.save
        end
      end
      if params[:cart_radio_option] == "D"
        @array_from_value.zip(@array_to_value) do |from_value,to_value|
          @discount_cart_values=DiscountCartValue.new(discount_id: @cart_discount.id,from_value: from_value,to_value: to_value)
          @discount_cart_values.save
        end
      end
    end

    if params[:discount_type_name] == "BOGO"
      @discount_offer=DiscountOffer.find_by(value: params[:bsgs_radio_option])
      puts @discount_offer.as_json
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])
      puts @discount_offer_type.as_json
      @count=Discount.where(discount_offer_type_id: @discount_offer_type.id)
      if params[:item_discount_type] == "Automatic"
        @bsgs_discount=Discount.new(name: "Buy Something..."+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: true,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty_bogo],bogo_get_qty: params[:Get_qty_bogo],bogo_buy_qty: params[:Buy_qty_bogo])
      else
        @bsgs_discount=Discount.new(name: "Buy Something..."+(@count1.size+1).to_s,promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty_bogo],bogo_get_qty: params[:Get_qty_bogo],bogo_buy_qty: params[:Buy_qty_bogo])
      end
      @bsgs_discount.save

      @array_buy_item_id_value=[]
      params[:buy_item_id].split(",") do |param_buy_item_id|
        @array_buy_item_id_value << param_buy_item_id.to_i
      end
      @array_get_item_id_value=[]
      params[:get_item_id].split(",") do |param_get_item_id|
        @array_get_item_id_value << param_get_item_id.to_i
      end

      @catalog=Catalog.where(pricing_id: @bsgs_discount.pricing_id,checked: true)
      @catalog.each do |catalog|
        if @array_buy_item_id_value.include? catalog.id
          @discount_bsgs_buy_list=DiscountBsgsBuyItem.new(catalog_id: catalog.id,active: true,discount_id: @bsgs_discount.id)
        else
          @discount_bsgs_buy_list=DiscountBsgsBuyItem.new(catalog_id: catalog.id,active: false,discount_id: @bsgs_discount.id)
        end
        @discount_bsgs_buy_list.save
      end
      puts @array_get_item_id_value
      @catalog.each do |catalog|
        if @array_get_item_id_value.include? catalog.id
          @discount_bsgs_get_list=DiscountBsgsGetItem.new(catalog_id: catalog.id,active: true,discount_id: @bsgs_discount.id)
        else
          @discount_bsgs_get_list=DiscountBsgsGetItem.new(catalog_id: catalog.id,active: false,discount_id: @bsgs_discount.id)
        end
        @discount_bsgs_get_list.save
      end

    end

    if params[:discount_type_name] == "Package"
      # @choices = params.select { |key, value| key.to_s.match(/^packageItem-child-\d+/) }
      # @choices = params.select { |x| x =~ /packageItem-child-/ }.values
      # @choices = params.map { |key, value| key =~ /\ApackageItem-child-/ && value }.compact
      @choices = params.select { |e| e.start_with? 'packageItem-child-' }.values
      @add_quantity = params.select { |e| e.start_with? 'qty-packageItem-child-' }.values
      puts @add_quantity
      puts "@@@@@@@@@@@"
      puts @choices
      @count=Discount.where("discount_offer_type_id = ?",17)
      puts @count.count
      if params[:item_discount_type] == "Automatic"
        @package_discount=Discount.new(name: "Package"+(@count.size+1).to_s,discount_offer_type_id: 17,promocode: params[:'step-1-promo'],use_limit: params[:promocode_limit],is_automatic: true,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:package_qty],package_price: params[:package_price],package_shipping: params[:package_shipping])
      else
        @package_discount=Discount.new(name: "Package"+(@count.size+1).to_s,discount_offer_type_id: 17,promocode: params[:'step-1-promo'],use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:package_qty],package_price: params[:package_price],package_shipping: params[:package_shipping])
      end
      @package_discount.save
      @choices.zip(@add_quantity).each do |choice,add_quantity|
        @package_discount1=PackageDiscount.new(discount_id: @package_discount.id,package_qty: add_quantity)
        @package_discount1.save
        puts choice
        choice.split(',').each do |c|
          puts "_____"
          puts c
          @package_discount_item=PackageDiscountItem.new(package_discount_id: @package_discount1.id,catalog_id: c)
          @package_discount_item.save
        end
      end
    end
    redirect_to discounts_path(id: params[:pricing_id])
  end


  def edit_discounts
    puts params
    @discount=Discount.find(params[:id])
    puts @discount.as_json
    @discount_offer_type=DiscountOfferType.find(@discount.discount_offer_type_id)
    @discount_type=DiscountType.find(@discount_offer_type.discount_type_id)
    if @discount.discount_offer_type_id != 17
      puts @discount.discount_offer_type_id
      puts "@@@@@@@@"
      @discount_offer=DiscountOffer.find(@discount_offer_type.discount_offer_id)
    else
      @discount_offer=DiscountOffer.find(1)
    end
    @groups=Group.where(pricing_id: @discount.pricing_id)
    @catalog_items=Catalog.where(pricing_id: @discount.pricing_id,checked: true)
    @array=@catalog_items.uniq.pluck(:item_list_id)
    puts "this is the array sort"
    @compact_array =  @array.compact
    puts "************"
    puts @compact_array

    @list_item_id_array = @compact_array.sort
    @discount_bsgs_get_items=DiscountBsgsGetItem.where(discount_id: @discount.id)
    @discount_bsgs_buy_items=DiscountBsgsBuyItem.where(discount_id: @discount.id)
    @discount_cart_values=DiscountCartValue.where(discount_id: @discount.id)
    @d=DiscountItemsList.where(discount_id: @discount.id)
    @groups_list=DiscountGroupsList.where(discount_id: @discount.id)
    @package_discounts=PackageDiscount.where(discount_id: @discount.id)
    @package_discount_items=PackageDiscountItem.all
    puts @package_discounts.count
    puts "_____________________"

    respond_to do |format|
      format.js
    end
  end
  def update_discount
    puts params
    @discount=Discount.find(params[:discount_id])
    # @discount_type=DiscountType.find(@discount_offer_type.discount_type_id)
    if params[:discount_type_name] == "Item"
      @discount_offer=DiscountOffer.find_by(value: params[:item_radio_option])
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])
      if params[:item_radio_option] == "A"
        @value = params[:edit_off_each_selected_item_value]
      elsif params[:item_radio_option] == "E"
        @value = params[:edit_percent_off_each_item_value]
      elsif params[:item_radio_option] == "B"
        @value = params[:edit_cost_for_each_item_value]
      else
        @value = ''
      end
      if params[:item_discount_type] == "Automatic"
        @discount.update(discount_offer_type_id: @discount_offer_type.id,promocode: nil,use_limit: nil,is_automatic: true,quantity: params[:Qty],checkout_limit: params[:checkout_limit],value: @value,expiration_date: params[:edit_promocode_expiration])
      else
        @discount.update(discount_offer_type_id: @discount_offer_type.id,promocode: params[:'step-1-promo'],use_limit: params[:promocode_limit],is_automatic: false,expiration_date: params[:promocode_expiration],quantity: params[:Qty],checkout_limit: params[:checkout_limit],value: @value,expiration_date: params[:edit_promocode_expiration])
      end
      @discount_items_list=DiscountItemsList.where(discount_id: params[:discount_id])
      puts @discount_items_list.as_json
      @item_id=[]
      if params[:item_id].present?
        params[:item_id].each do |param1|
          @item_id << param1.to_i
        end
      end
      DiscountItemsList.where(discount_id: params[:id]).update_all(active: false)
      @item_id.each do |item|
        puts item
        # DiscountItemsList.where("catalog_id = ? AND discount_id = ?",item,params[:discount_id]).update_all(active: true)
        @discount_items_list.find_by(catalog_id: item).update(active: true)
      end
    elsif params[:discount_type_name] == "Credit"
      @discount_offer=DiscountOffer.find_by(value: params[:credit_radio_option])
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])

      if params[:credit_radio_option] == "A"
        @value = params[:edit_credit_off_each_selected_item_value]
      else
        @value = -1
      end
      if params[:item_discount_type] == "Automatic"
        @discount.update(promocode: nil,discount_offer_type_id: @discount_offer_type.id,use_limit: nil,is_automatic: true,checkout_limit: params[:checkout_limit],quantity: params[:Qty],value: @value,expiration_date: params[:edit_promocode_expiration])
      else
        puts "________"
        @discount.update(promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:checkout_limit],quantity: params[:Qty],value: @value,expiration_date: params[:edit_promocode_expiration])
      end
    elsif params[:discount_type_name] == "Group"
      @discount_offer=DiscountOffer.find_by(value: params[:group_radio_option])
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])
      if params[:group_radio_option] == "A"
        @value = params[:edit_group_off_each_selected_item_value]
      elsif params[:group_radio_option] == "E"
        @value = params[:edit_group_percent_off_each_item_value]
      elsif params[:group_radio_option] == "B"
        @value = params[:edit_group_cost_for_each_item_value]
      else
        @value = ''
      end
      if params[:item_discount_type] == "Automatic"
        @discount.update(promocode: nil,discount_offer_type_id: @discount_offer_type.id,use_limit: nil,is_automatic: true,checkout_limit: params[:edit_checkout_limit],quantity: params[:edit_group_quantity],value: @value,expiration_date: params[:edit_promocode_expiration])
      else
        @discount.update(promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:edit_checkout_limit],quantity: params[:edit_group_quantity],value: @value,expiration_date: params[:edit_promocode_expiration])
      end
      @group_id=[]
      if params[:group_id].present?
        params[:group_id].each do |param1|
          @group_id << param1.to_i
        end
      end
      DiscountGroupsList.where(discount_id: params[:discount_id]).update_all(active: false)
      @discount_groups_list=DiscountGroupsList.where(discount_id: params[:discount_id])
      @group_id.each do |group|
        # DiscountItemsList.where("catalog_id = ? AND discount_id = ?",item,params[:discount_id]).update_all(active: true)
        @discount_groups_list.find_by(group_id: group).update(active: true)
      end
    elsif params[:discount_type_name] == "BOGO"
      @discount_offer=DiscountOffer.find_by(value: params[:bsgs_radio_option])
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])
      @discount_bsgs_get_items=DiscountBsgsGetItem.where(discount_id: @discount.id)
      @discount_bsgs_buy_items=DiscountBsgsBuyItem.where(discount_id: @discount.id)
      if params[:bsgs_radio_option] == "E"
        @value = params[:edit_bsgs_percent_off_each_item_value]
      elsif params[:bsgs_radio_option] == "B"
        @value = params[:edit_bsgs_cost_for_each_item_value]
      else
        @value = ''
      end
      if params[:item_discount_type] == "Automatic"
        @discount.update(promocode: nil,discount_offer_type_id: @discount_offer_type.id,use_limit: nil,is_automatic: true,checkout_limit: params[:edit_checkout_limit],quantity: params[:edit_qty_bogo],bogo_get_qty: params[:edit_get_qty_bogo],bogo_buy_qty: params[:edit_buy_qty_bogo],value: @value,expiration_date: params[:edit_promocode_expiration])
      else
        @discount.update(promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,pricing_id: params[:pricing_id],checkout_limit: params[:edit_checkout_limit],quantity: params[:edit_qty_bogo],bogo_get_qty: params[:edit_get_qty_bogo],bogo_buy_qty: params[:edit_buy_qty_bogo],value: @value,expiration_date: params[:edit_promocode_expiration])
      end
      @array_buy_item_id_value=[]
      if params[:buy_item_id].present?
        params[:buy_item_id].split(",") do |param_buy_item_id|
          @array_buy_item_id_value << param_buy_item_id.to_i
        end
      end
      @array_get_item_id_value=[]
      if params[:get_item_id].present?
        params[:get_item_id].split(",") do |param_get_item_id|
          @array_get_item_id_value << param_get_item_id.to_i
        end
      end
      DiscountBsgsGetItem.where(discount_id: params[:discount_id]).update_all(active: false)
      DiscountBsgsBuyItem.where(discount_id: params[:discount_id]).update_all(active: false)
      @discount_bsgs_get_list=DiscountBsgsGetItem.where(discount_id: params[:discount_id])
      @discount_bsgs_buy_list=DiscountBsgsBuyItem.where(discount_id: params[:discount_id])

      puts @array_get_item_id_value.length
      puts @array_buy_item_id_value.length
      if @array_get_item_id_value.size > 0
        @array_get_item_id_value.each do |get_item_id|
          @discount_bsgs_get_list.find_by(catalog_id: get_item_id).update(active: true)
        end
      end
      if @array_buy_item_id_value.size > 0
        @array_buy_item_id_value.each do |buy_item_id|
          @discount_bsgs_buy_list.find_by(catalog_id: buy_item_id).update(active: true)
        end
      end
    elsif params[:discount_type_name] == "Cart"
      puts params[:item_discount_type]
      @discount_offer=DiscountOffer.find_by(value: params[:cart_radio_option])
      @discount_offer_type=DiscountOfferType.find_by(discount_offer_id: @discount_offer.id,discount_type_id: params[:discount_type_id])
      if params[:item_discount_type] == "Automatic"
        @discount.update(promocode: nil,discount_offer_type_id: @discount_offer_type.id,use_limit: nil,is_automatic: true,expiration_date: nil)
      else
        @discount.update(promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,expiration_date: params[:edit_promocode_expiration])
      end
      DiscountCartValue.where(discount_id: @discount.id).destroy_all
      puts "______________"

      @array_from_value=[]
      params[:From_Value].split(",") do |param_from|
        @array_from_value << param_from.to_i
      end
      @array_to_value=[]
      params[:To_Value].split(",") do |param_to|
        @array_to_value << param_to.to_i
      end
      if params[:cart_radio_option] == "E"
        @array_cart_percentage=[]
        params[:cart_percentage].split(",") do |param_cart_percentage|
          @array_cart_percentage << param_cart_percentage.to_i
        end
        @array_from_value.zip(@array_to_value,@array_cart_percentage) do |from_value,to_value,percent_value|
          @discount_cart_values=DiscountCartValue.new(discount_id: @discount.id,from_value: from_value,to_value: to_value,percentage_value: percent_value,dollar_value: nil)
          @discount_cart_values.save
        end
      end
      if params[:cart_radio_option] == "A"
        @array_cart_dollar=[]
        params[:cart_dollar].split(",") do |param_cart_dollar|
          @array_cart_dollar << param_cart_dollar.to_i
        end
        @array_from_value.zip(@array_to_value,@array_cart_dollar) do |from_value,to_value,dollar_value|
          @discount_cart_values=DiscountCartValue.new(discount_id: @discount.id,from_value: from_value,to_value: to_value,dollar_value: dollar_value,percentage_value: nil)
          @discount_cart_values.save
        end
      end
      if params[:cart_radio_option] == "D"
        @array_from_value.zip(@array_to_value) do |from_value,to_value|
          @discount_cart_values=DiscountCartValue.new(discount_id: @discount.id,from_value: from_value,to_value: to_value,percentage_value: nil,dollar_value: nil)
          @discount_cart_values.save
        end
      end
    else
      puts params[:item_discount_type]
      puts params.select { |e| e.start_with? 'packageItem-child-' }
      @choices = params.select { |e| e.start_with? 'packageItem-child-' }.values
      @add_quantity = params.select { |e| e.start_with? 'qty-packageItem-child-' }.values
      puts @add_quantity
      puts "@@@@@@@@@@@"
      puts @choices
      # @discount_offer=DiscountOffer.find_by(value: params[:cart_radio_option])
      @discount_offer_type=DiscountOfferType.find_by(discount_type_id: params[:discount_type_id])
      if params[:item_discount_type] == "Automatic"
        @discount.update(promocode: nil,discount_offer_type_id: @discount_offer_type.id,use_limit: nil,is_automatic: true,expiration_date: nil,quantity: params[:package_qty],package_price: params[:package_price],package_shipping: params[:package_shipping])
      else
        @discount.update(promocode: params[:'step-1-promo'],discount_offer_type_id: @discount_offer_type.id,use_limit: params[:promocode_limit],is_automatic: false,expiration_date: params[:edit_promocode_expiration],quantity: params[:package_qty],package_price: params[:package_price],package_shipping: params[:package_shipping])
      end

      @choices.each do |choice|
        choice.split(",").each do |c|
          puts c
        end
      end

      PackageDiscount.where(discount_id: @discount.id).destroy_all
      @choices.zip(@add_quantity).each do |choice,add_quantity|
        @package_discount = PackageDiscount.new(discount_id: @discount.id,package_qty: add_quantity)
        @package_discount.save
        choice.split(',').each do |c|
          @package_discount_item = PackageDiscountItem.new(package_discount_id: @package_discount.id,catalog_id: c)
          @package_discount_item.save
        end
      end
    end
    redirect_to discounts_path(id: @discount.pricing_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discount_params
      params.fetch(:discount, {})
    end
end
