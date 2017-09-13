class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_order, only: [:show, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /orders
  # GET /orders.json
  def index
    if @current_user_permissions.find_by(permission_name: "View Orders").value == false
      @not_authorized = true
    end
    @order=current_brand.orders.all
    @orders = current_brand.checkouts.order(id: :asc)
    puts current_brand.inspect
    puts "******************"
    # @orders = Order.includes(:gallery).order(sort_column + " " + sort_direction).where(galleries: {user_id: current_user.id } )
    @orders = @orders.order_name(params[:order_name]) if params[:order_name].present?
    @orders = @orders.f_l_name(params[:name]) if params[:name].present?
    @orders = @orders.email(params[:email]) if params[:email].present?
    # @orders = @orders.status(params[:status]) if params[:status].present?
    gallery = Gallery.select(:name).find(params[:gallery]) if params[:gallery].present?
    # @orders = @orders.gallery(params[:gallery]) if params[:gallery].present?

    @galleries = Gallery.where(user_id: current_user.id, is_delete: false)


    # puts @orders.as_json

  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def mail_sent
   OrderMailer.order_email(params[:email],params[:message],params[:order]).deliver
    redirect_to edit_order_path(params[:order])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @order = Checkout.find(params[:id])
    @checkout_status = CheckoutStatus.where('id NOT IN (?)',[3,6])
    @line_items = @order.line_items
    @photos = Photo.all
    @file_name_array = []
    @line_items.each do |line_item|
      @name = line_item.photo.image_file_name.split(".").first
      unless @file_name_array.include?(@name)
        @file_name_array << @name
      end
    end
  end

  def bulkaction
    puts params
    params[:id_order].split(",").each do |id|
      puts id

      if params[:myVal]=="Mark Paid"
        @update_order=Checkout.find_by(id: id).update(success: "t")
      elsif params[:myVal]=="Mark Pending"
        @update_order=Checkout.find_by(id: id).update(checkout_status_id: 2)
      elsif params[:myVal]=="Mark Shipped"
        @update_order=Checkout.find_by(id: id).update(checkout_status_id: 4)
      elsif params[:myVal]=="Mark Completed"
        @update_order=Checkout.find_by(id: id).update(checkout_status_id: 5)
      else
        @update_order=Checkout.find_by(id: id).update(checkout_status_id: 7)
      end
    end

    redirect_to orders_path
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    puts params.inspect
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if @current_user_permissions.find_by(permission_name: "Edit Orders").value == false
      @not_authorized = true
      render :edit
    else
      respond_to do |format|
        if @order.update(checkout_status_id: params[:checkout]['checkout_status_id'])
          format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def status_change

  end
  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
# def complete
#   Task.update_all(["completed_at=?", Time.now], :id => params[:task_ids])
# end
#   def bulk_update
#     Order.update_all(["status=?","new"]), :id =>
#   end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Checkout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:email_id, :first_name, :last_name, :address, :city, :country, :pin, :phone_no, :notes_to_studio, :gallery_id, :studio_internal_notes, :status,:paid).merge(brand_id: current_brand.id)
    end

    def sort_column
      if params[:sort]
        params[:sort]
      else
       params[:sort] = "orders.id"
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
