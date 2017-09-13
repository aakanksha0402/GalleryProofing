# require "RMagick"
# require 'watermark_image'
class BrandsController < ApplicationController
  # include WatermarkImage
  before_filter :authenticate_user!
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # after_action  :create_default_watermark, only: [:create]

  # GET /brands
  # GET /brands.json
  def index
    if @current_user_permissions.find_by(permission_name: "View Administration").value == false
      @not_authorized = true
    end

    @brands = current_user.brands.order(:brand_name)
    puts "==========#{@brands.inspect}========"
    @brand = Brand.new
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit

  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)
    respond_to do |format|
      if @brand.save
        @created = true
        format.js
        format.html { redirect_to brands_path, notice: 'Brand was successfully created.' }
        format.json { render :show, status: :created, location: @brand }
      else
        @created = false
        format.js
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    if @current_user_permissions.find_by(permission_name: "Edit Administration").value == false
      @not_authorized_to_edit = true
      render (:index)
    else
      respond_to do |format|
        if @brand.update(brand_params)
          @updated = true
          format.js
          format.html { redirect_to brands_path, notice: 'Brand was successfully updated.' }
          format.json { render :show, status: :ok, location: @brand }
        else
          @updated = false
          format.js
          # format.html { render :edit }
          format.json { render json: @brand.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_states
    @get_country = Country.find(params[:country_id])
    @get_states = Country.find(params[:country_id]).state_provinces
  end

  def change_brand
    @brand = Brand.find_by(user_id: current_user.id, default: true)
    @update_brand = Brand.where(id: @brand.id).update_all(default: false)
    if @update = Brand.where(id: params[:brand]).update_all(default: true)
      redirect_to brands_path
    else
      redirect_to brands_path
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_params
      params.require(:brand).permit(:brand_name, :website_url, :email, :address1, :address2, :city, :primary_country_id, :brand_country_id, :state_province_id, :pincode, :phone_number, :default, :brand).merge(:user_id => current_user.id)
    end

    # default water mark creation for each new brand.
    def create_default_watermark
      @watermark = Watermark.new
      @watermark.brand_id = @brand.id
      @watermark.name = "Studio Watermark"
      @watermark.text_name = current_user.studio_name
      @watermark.font_set = "Adler"
      @watermark.color = "Black"
      @watermark.text_opacity_value = 30
      @watermark.selected_as = true
      @watermark.is_default = true
      @watermark.is_first = true
      image1 = create_image_watermark("#{Rails.root}/app/assets/images/demo (1).jpg","Adler",\
          "Black",current_user.studio_name,30)
      image2 = create_image_watermark("#{Rails.root}/app/assets/images/demo.jpg","Adler",\
          "Black",current_user.studio_name,30)
      @watermark.watermark_image = image1
      @watermark.watermark_sample_image = image2
      @watermark.save!
    end
end
