require 'calculate_discount'
class CartsController < HomePagesController
  include CalculateDiscount
  before_filter :set_cache_headers

  before_action :requirements, only: [:view_cart]
  before_action :gallery_visitor, only: [:increase_quantity, :reduce_quantity, :add_to_cart, :remove_an_item, :empty_cart, :alter_quantity_in_cart,:update_cart_item]

  def view_items
    @brand = Brand.where(id: params[:brand]).first
    if @brand
      @gallery = Gallery.where(id: params[:gallery]).first
      if @gallery
        @custom_gallery_layout = @gallery.custom_gallery_layout
        puts "**********************#{@custom_gallery_layout.pricing_id.present?}******************************"
        if @custom_gallery_layout.pricing_id.present?
          @pricing = @custom_gallery_layout.pricing

          @cat = @pricing.catalogs.where(checked: true)

          @groups = Group.where("id IN(?)", @cat.pluck(:group_id)).order(:id)

          @catalogs = @cat.select(:print_size_one, :print_size_two, :group_id, :fix_group_id, :resolution).group(:print_size_one, :print_size_two, :group_id, :fix_group_id, :resolution).order(:print_size_one, :print_size_two)

          @digital = @cat.where("fix_group_id = ?", 2)

          # @all_catalogs = @pricing.catalogs.where(checked: true)
          # @var = @all_catalogs.uniq.select(:group_id)
          # @groups = @pricing.groups.where(id: @var)
          # @group_wise_catalogs = @all_catalogs.where("group_id IN(?)", @groups.ids)
          # @catalogs = @group_wise_catalogs.select(:print_size_one, :print_size_two, :group_id).group(:print_size_one, :print_size_two, :group_id)
          if params[:photo] == 'true'
            @photo = false
            @is_photo = true
          else
            @photo = Photo.find(params[:photo])
            @is_photo = false
          end
        end
      else
        redirect_to view_path
      end
    else
      render :file => 'public/error.html'
    end
  end

  def add_to_cart
    # @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: session["email_visitor_#{params[:gallery]}"]).first
    if @gallery_visitor
      @cart = cart(@gallery_visitor.id)
      @gallery = Gallery.find(params[:gallery])
      if params[:lineitem].present?
        @lineitem_obj = LineItem.find(params[:lineitem])
        @lineitem_obj.update_attribute(:quantity, params[:quantity])
      else
        if params[:is_photo] == 'true' && params[:from] != "3"
          @gallery.photos.each do |photo|
             @line_item = @cart.line_items.build(photo: photo, quantity: params[:quantity], catalog_id: params[:catalog],from: params[:from])
             @line_item.save
          end
        else
          if params[:is_photo] == 'true' && params[:from] == "3"
            params[:photo] = @gallery.photos.order("RANDOM()").first
          end
          @photo = Photo.find(params[:photo])
          @line_item = @cart.line_items.build(photo: @photo, quantity: params[:quantity], catalog_id: params[:catalog],from: params[:from])
          @line_item.save
        end
      end
    end
  end
  def add_promocode
    gallery = Gallery.find(params[:gallery])
    promocode_found = gallery.custom_gallery_layout.pricing.discounts.where(promocode: params[:promo]).first
    @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", params[:gallery], session["email_visitor_#{params[:gallery]}"]).first
    @cart = cart(@gallery_visitor.id)
    cart_promocode = @cart.used_promocodes.where(promocode: params[:promo]).first
    if  !cart_promocode.present? && promocode_found.present?
      used_promocode = UsedPromocode.new
      used_promocode.promocode = params[:promo]
      used_promocode.cart_id = @cart.id
      used_promocode.save
    end
    respond_to do |format|
      if promocode_found.present?
        if params[:from_checkout].present?
          format.html {redirect_to checkout_path(brand: params[:brand], gallery: params[:gallery]) }
        else
          format.html {redirect_to view_cart_path(brand: params[:brand], gallery: params[:gallery],from: params[:from],promo: params[:promo])}
        end
      else
        if params[:from_checkout].present?
          format.html {redirect_to checkout_path(brand: params[:brand], gallery: params[:gallery]), notice: "Invalid promo code: #{params[:promo]}" }
        else
          format.html {redirect_to view_cart_path(brand: params[:brand], gallery: params[:gallery],from: params[:from],promo: params[:promo]), notice: "Invalid promo code: #{params[:promo]}"}
        end
      end
    end
  end
  def remove_promocode
    @used_promocode = UsedPromocode.find(params[:promo])
    @used_promocode.destroy

    respond_to do |format|
      if params[:from_checkout].present?
          format.html {redirect_to checkout_path(brand: params[:brand], gallery: params[:gallery]) }
      else
        format.html { redirect_to view_cart_path(brand: params[:brand], gallery: params[:gallery],from: params[:from],promo: params[:promo]) }
      end
      format.xml  { head :ok }
    end
  end
  def update_cart_item
    if params[:lineitem].present?
        @lineitem_obj = LineItem.find(params[:lineitem])
        @lineitem_obj.update_attribute(:quantity, params[:quantity])
    end
    render :add_to_cart
  end

  def save_email
    @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: params[:email]).first
    if @gallery_visitor.nil?
      @gallery_visitor = GalleryVisitor.create(gallery_id: params[:gallery], email: params[:email])
      @gallery_visitor.save
    end
    session["email_visitor_#{@gallery_visitor.gallery_id}"] = @gallery_visitor.email
    @cart = cart(@gallery_visitor.id)
    @gallery = Gallery.find(params[:gallery])
    if params[:lineitem].present?
      @lineitem_obj = LineItem.find(params[:lineitem])
      @lineitem_obj.update_attribute(:quantity, params[:quantity])
    else
      if params[:is_photo] == 'true' && params[:from] != "3"
        @gallery.photos.each do |photo|
            @line_item = @cart.line_items.build(photo: photo, quantity: params[:quantity], catalog_id: params[:catalog],from: params[:from])
            @line_item.save
        end
      else
        if params[:is_photo] == 'true' && params[:from] == "3" ||  !params[:photo].present?
            params[:photo] = @gallery.photos.order("RANDOM()").first
        end
        @photo = Photo.find(params[:photo])
        @line_item = @cart.line_items.build(photo: @photo, quantity: params[:quantity], catalog_id: params[:catalog],from: params[:from])
        @line_item.save
      end
    end
    render :add_to_cart
  end

  def view_cart
    if session["email_visitor_#{params[:gallery]}"].present?
      @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", params[:gallery], session["email_visitor_#{params[:gallery]}"]).first
      if @gallery_visitor
        @cart = cart(@gallery_visitor.id)
        @discount = discount(@cart,params[:gallery],params[:promo])
        @total_discount = 0
        if @discount.present?
          @discount.each do |key,value|
            @total_discount += value
          end
        end
        @line_items = @cart.line_items
        if @line_items.present?
          @total_quantity = 0
          @line_items.each do |line_item|
            @total_quantity += line_item.quantity
          end
        end
      end
    end
  end

  def empty_cart
    if session["cart_id_#{@gallery_visitor.id}"]
      @cart = Cart.find(session["cart_id_#{@gallery_visitor.id}"])
      @line_items = @cart.line_items.destroy_all
    end
  end

  def remove_an_item
    puts "Session in remove an item: #{session['cart_id_#{@gallery_visitor.id}']}"
    if session["cart_id_#{@gallery_visitor.id}"]
      @cart = cart(@gallery_visitor.id)
      if @cart.present?
        @line_item = @cart.line_items.find(params[:line_item_id])
        @line_item.destroy
      end
    end
    puts "removed"
  end

  def reduce_quantity
    # @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: session["email_visitor_#{params[:gallery]}"]).first
    if session["cart_id_#{@gallery_visitor.id}"]
      @cart = cart(@gallery_visitor.id)
      if @cart.present?
        @line_item = @cart.line_items.find(params[:line_item_id])
        @line_item.update(quantity: @line_item.quantity-1)
      end
    end
    puts "reduced"
  end

  def increase_quantity
    # @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: session["email_visitor_#{params[:gallery]}"]).first
    if session["cart_id_#{@gallery_visitor.id}"]
      @cart = cart(@gallery_visitor.id)
      if @cart.present?
        @line_item = @cart.line_items.find(params[:line_item_id])
        @line_item.update(quantity: @line_item.quantity+1)
      end
    end
    puts "increased"
  end

  def alter_quantity_in_cart
    if session["cart_id_#{@gallery_visitor.id}"]
      @cart = cart(@gallery_visitor.id)
      @line_item = @cart.line_items.find(params[:line_item_id])
      if params[:quantity] == ""
        params[:quantity] = 1
      end
      if params[:quantity].to_i >= 1 && params[:quantity].to_i <=9999
        @line_item.update(quantity: params[:quantity])
      end
      @price = @line_item.quantity * @line_item.catalog.price
    end
    puts "changed"
  end


  def verify_email
    if params[:email] == params[:confirm_email]
      @pass = true
      @gallery = Gallery.find(params[:gallery])
      @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", @gallery.id, params[:email]).first
      if @gallery_visitor.nil?
        @gallery_visitor =  GalleryVisitor.create!(gallery_id: @gallery.id, email: params[:email])
      end
      session["email_visitor_#{@gallery.id}"] = @gallery_visitor.email
      @cart = cart(@gallery_visitor.id)
      puts "call session method from favorites."
    else
      @pass = false
    end
  end

  private

  def requirements
    @brand = Brand.where(id: params[:brand]).first
    if @brand
      @gallery = Gallery.where("brand_id = ? AND id = ?", @brand.id, params[:gallery]).first
      if @gallery
        @custom_gallery_layout = CustomGalleryLayout.where(gallery_id: @gallery.id).first
        if @custom_gallery_layout.email_require == true && session["email_visitor_#{@gallery.id}"].nil?
          redirect_to view_gallery_path
        else
          @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", @gallery.id, session["email_visitor_#{@gallery.id}"]).first
          if @gallery_visitor
            @cart = cart(@gallery_visitor.id)
          # else
          #   redirect_to view_gallery_path
          end
        end
      else
        render :file => 'public/error.html'
      end
    else
      render :file => 'public/error.html'
    end
  end

  def gallery_visitor
   @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: session["email_visitor_#{params[:gallery]}"]).first
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
