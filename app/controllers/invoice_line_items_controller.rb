class InvoiceLineItemsController < ApplicationController
  before_action :set_invoice_line_item, only: [:show, :edit, :update, :destroy]

  # GET /invoice_line_items
  # GET /invoice_line_items.json
  def index
    @invoice_line_items = current_brand.invoice_line_items.all
    puts @invoice_line_items.as_json
    @invoice_line_item = InvoiceLineItem.new
  end

  # GET /invoice_line_items/1
  # GET /invoice_line_items/1.json
  def show
  end

  # GET /invoice_line_items/new
  def new
    @invoice_line_item = InvoiceLineItem.new
  end

  # GET /invoice_line_items/1/edit
  def edit
  end

  # POST /invoice_line_items
  # POST /invoice_line_items.json
  def create
    @invoice_line_item = InvoiceLineItem.new(invoice_line_item_params)
    @invoice_line_item.brand_id = current_brand.id

    respond_to do |format|
      if @invoice_line_item.save
        @created = true
        format.js
        format.html { redirect_to invoice_line_items_path(id: current_user.id), notice: 'Invoice line item was successfully created.' }
        format.json { render :show, status: :created, location: @invoice_line_item }
      else
        @created = false
        format.js
        format.html { render :new }
        format.json { render json: @invoice_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoice_line_items/1
  # PATCH/PUT /invoice_line_items/1.json
  def update
    respond_to do |format|
      if @invoice_line_item.update(invoice_line_item_params)
        format.html { redirect_to @invoice_line_item, notice: 'Invoice line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice_line_item }
      else
        format.html { render :edit }
        format.json { render json: @invoice_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_line_items/1
  # DELETE /invoice_line_items/1.json
  def destroy
    @invoice_line_item.destroy
    respond_to do |format|
      format.html { redirect_to invoice_line_items_url, notice: 'Invoice line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def save_invoice_line_item
    puts params
    @invoice_line_item = InvoiceLineItem.new(name: params[:name],description: params[:description],quantity: params[:quantity],price: params[:price],is_taxable: params[:is_taxable],total_price: params[:total_price])
    @invoice_line_item.brand_id = current_brand.id
    @invoice_line_item.save
    redirect_to new_invoice_path(id: current_user.id)
  end

  def item_update
    puts params
    @invoice_line_item = InvoiceLineItem.find(params[:id])
    puts "*******************"
    puts @invoice_line_item.present?
    puts "*******************"
    respond_to do |format|
      format.js
    end
  end

  def update_details
    puts params
    @invoice_line_item = InvoiceLineItem.find(params[:line_item_id])
    @invoice_line_item.update(name: params[:name],description: params[:description],quantity: params[:quantity].to_i,price: params[:price].to_f,is_taxable: params[:is_taxable],total_price: params[:quantity].to_i * params[:price].to_f)
    redirect_to invoice_line_items_path(id: current_brand.id)
  end

  def delete_line_item
    puts params
    @invoice_line_item = InvoiceLineItem.find(params[:id])
    @invoice_line_item.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_line_item
      @invoice_line_item = InvoiceLineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_line_item_params
      params.require(:invoice_line_item).permit(:name,:description,:quantity,:price,:is_taxable)
    end
end
