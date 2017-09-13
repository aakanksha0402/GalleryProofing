require 'calculate_discount'
class CheckoutsController < HomePagesController
  require 'active_merchant'
  include CalculateDiscount

  before_filter :set_cache_headers
  before_action :requirements, only: [:checkout, :create]
  before_action :data, only: [:checkout, :create]
  before_action :gallery_visitor, only: [:get_shipping, :remove_shipping, :apply_shipping]

  def checkout

  end


  def update

    if @current_user_permissions.find_by(permission_name: "Edit Orders").value == false
      @not_authorized = true
      render :edit
    else
      @order = Checkout.find(params[:id])
      respond_to do |format|
        if @order.update(checkout_params)
          format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html {redirect_to :back }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def index
    @checkouts = current_brand.checkouts.order(id: :asc)
    # @checkouts = Order.includes(:gallery).order(sort_column + " " + sort_direction).where(galleries: {user_id: current_user.id } )
    @checkouts = @checkouts.order_name(params[:order_name]) if params[:order_name].present?
    @checkouts = @checkouts.f_l_name(params[:name]) if params[:name].present?
    @checkouts = @checkouts.email(params[:email]) if params[:email].present?
    @checkouts = @checkouts.status(params[:status]) if params[:status].present?
    gallery = Gallery.select(:name).find(params[:gallery]) if params[:gallery].present?
    @checkouts = @checkouts.gallery(gallery.name) if params[:gallery].present?

  end

  def create
    @checkout = Checkout.create(checkout_params)
    @checkout.gallery_visitor_id = @gallery_visitor.id
    if params[:checkout][:same_billing_address] == "1"
      @checkout.shipping_state_id = params[:checkout_shipping_state_id]
      @checkout.billing_first_name = @checkout.shipping_first_name
      @checkout.billing_last_name = @checkout.shipping_last_name
      @checkout.billing_addr1 = @checkout.shipping_addr1
      @checkout.billing_addr1 = @checkout.shipping_addr2
      @checkout.billing_country_id = @checkout.shipping_country_id
      @checkout.billing_city = @checkout.shipping_city
      @checkout.billing_state_id = @checkout.shipping_state_id
      @checkout.billing_postal_code = @checkout.shipping_postal_code
    end
    puts "yo"
    @checkout.update(same_billing_address: params[:checkout][:same_billing_address],payed_using: params[:checkout][:payed_using], payment_option: params[:checkout][:payment_option])
    if @checkout.save
      if @checkout.payment_option == "true"
        if @gateway_found.name == "Braintree"
          if @checkout.braintree
            @cart.update_attributes(is_active: false)
            @cart.line_items.update_all(is_active: false, cart_id: nil, checkout_id: @checkout.id)
            # @cart.destroy
            session.delete("cart_id_#{@gallery_visitor.id}")
          else
            @checkout.update(success: "Payment Failed")
          end
        elsif @gateway_found.name == "Pro"
          if @checkout.paypal
            @cart.update_attributes(is_active: false)
            @cart.line_items.update_all(is_active: false, cart_id: nil, checkout_id: @checkout.id)
            # @cart.destroy
            session.delete("cart_id_#{@gallery_visitor.id}")
          else
            @checkout.update(success: "Payment Failed")
          end
        elsif @gateway_found.name == "standard"
          session[:checkout] = @checkout.id
          session[:amount] = @checkout.amount
          session[:gateway_credentials] = @gateway_found.secure_merchant_account_id
          session[:brand_name] = @brand.brand_name
          session[:brand_name] = @cart.line_items.count
          session[:redirect_flag] = true
          redirect_to paypalbump_path
        end
      else
        @checkout.update_attributes(success: "Pay Later; Pending")
        @cart.update_attributes(is_active: false)
        @cart.line_items.update_all(is_active: false, cart_id: nil, checkout_id: @checkout.id)
        # @cart.destroy
        session.delete("cart_id_#{@gallery_visitor.id}")
      end
    else
      render action: :checkout
    end
  end

  def get_states
    @shipping_states = StateProvince.where(country_id: params[:shipping_country_id])
    @billing_states = StateProvince.where(country_id: params[:billing_country_id])
  end

  def get_shipping
    # @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: session["email_visitor_#{params[:gallery]}"]).first
    @cart = Cart.find(session["cart_id_#{@gallery_visitor.id}"])
    @price = @cart.total_price
    @shipping_price = ShippingOption.find(params[:shipping_option]).price
    @total_price = @price.to_d + @shipping_price.to_d
  end

  def remove_shipping
    # @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: session["email_visitor_#{params[:gallery]}"]).first
    @cart = Cart.find(session["cart_id_#{@gallery_visitor.id}"])
    @total_price = @cart.total_price
  end

  def apply_shipping
    # @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: session["email_visitor_#{params[:gallery]}"]).first
    @cart = Cart.find(session["cart_id_#{@gallery_visitor.id}"])
    @shipping_method_option = ShippingOption.find(params[:shipping_option])
    @total_price = @cart.total_price.to_d + @shipping_method_option.price.to_d
  end

  def paypalbump
    @checkout = session[:checkout]
    @gateway_credentials = session[:gateway_credentials]
    @brand = session[:brand_name]
    @photos = session[:count]
    @amount = session[:amount]
    session.delete('checkout')
    session.delete('gateway_credentials')
    session.delete('brand_name')
    session.delete('checkout')
    if session[:redirect_flag] == true
      session[:redirect_flag] = false
    else
      render :file => 'public/error.html'
    end
  end

  private

  def checkout_params
    params.require(:checkout).permit(:email, :phone_number, :shipping_first_name, :shipping_last_name, :shipping_addr1, :shipping_addr2, :shipping_country_id, :shipping_city, :shipping_state_id, :shipping_postal_code, :billing_first_name, :billing_last_name, :billing_addr1, :billing_addr2, :billing_country_id, :billing_city, :billing_state_id, :billing_postal_code, :shipping_method, :payment_option, :card, :month, :year, :cvc, :amount, :same_billing_address, :payed_using, :brand_id).merge(checkout_status_id: 1)
  end

  def requirements
    @brand = Brand.where(id: params[:brand]).first
    if @brand
      @gallery = Gallery.where("brand_id = ? AND id = ?", @brand.id, params[:gallery]).first
      if @gallery
        @custom_gallery_layout = CustomGalleryLayout.where(gallery_id: @gallery.id).first
        if @custom_gallery_layout.email_require? && session["email_visitor_#{@gallery.id}"].nil?
         redirect_to view_path
        else
          @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", @gallery.id, session["email_visitor_#{@gallery.id}"]).first
          if @gallery_visitor
            if session["cart_id_#{@gallery_visitor.id}"]
              @cart = Cart.find(session["cart_id_#{@gallery_visitor.id}"])
            else
              redirect_to view_gallery_path
            end
          else
            redirect_to view_gallery_path
          end
        end
      else
        render :file => 'public/error.html'
      end
    else
      render :file => 'public/error.html'
    end
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def data
    @line_items = @cart.line_items
    if @line_items.count >= 1
      @total_items = 0
      @line_items.each do |line_item_price|
        @total_items += line_item_price.quantity
      end
      @discount = discount(@cart,@gallery,params[:promo])
      puts "LALALALALLALALAL"
      puts @discount
        @total_discount = 0
        if @discount.present?
          @discount.each do |key,value|
            puts key
            puts value
            @total_discount += value
          end
        end
      @subtotal_price = @cart.total_price
      @total_price = @subtotal_price.to_d - @total_discount
      @pricing = @custom_gallery_layout.pricing
      @checkout = Checkout.new
      if @pricing.nil?
        @line_items.destroy_all
        redirect_to view_gallery_path
      else
        @shipping = @pricing.shipping
        @shipping_option = @shipping.shipping_options
        if @shipping_option.present?
          @total_price += @shipping_option.first.price.to_d
        end
      end
      @gateway_found = GatewaySetup.where(user_id: @brand.user_id).first
    else
      redirect_to view_cart_path
    end
  end

  def gallery_visitor
    @gallery_visitor = GalleryVisitor.where(gallery_id: params[:gallery], email: session["email_visitor_#{params[:gallery]}"]).first
  end
end
