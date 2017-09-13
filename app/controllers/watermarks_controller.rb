require "RMagick"
require 'watermark_image'
class WatermarksController < ApplicationController
  include WatermarkImage
  before_filter :authenticate_user!
  before_action :set_watermark, only: [:show,:destroy]
  before_action :set_text_name, only: [:edit]
  before_action :set_watermark_image, only: [:update]
  after_action :set_image, only: [:update]
  # GET /watermarks
  # GET /watermarks.json
  def index
    @first = false
    @watermarks = Watermark.where(brand_id: current_brand.id).order('id ASC')
    @watermark = Watermark.new
    @brand = Brand.find(current_brand.id)
    puts current_brand.id
    if @watermarks.count == 1
      @watermarks.each do |f|
        @first = f.is_first
        @watermark_id = f.id
        puts "---------------------------------"
        puts @watermark_id
      end
    end
  end

  # GET /watermarks/1
  # GET /watermarks/1.json
  def show
  end

  # GET /watermarks/new
  def new
    @watermark = Watermark.new
    @watermark.name = params[:name]
      puts "MMMMMMMMMMMMMMMMMMMMMM"
      puts current_brand.id
      @watermark.brand_id = current_brand.id
      @watermark.name = "Studio Watermark"
      @watermark.text_name = current_user.studio_name
      @watermark.font_set = "Americana"
      @watermark.color = "Black"
      @watermark.text_opacity_value = 30
      @watermark.selected_as = true
      @watermark.is_default = true
      @watermark.is_first = true
      image1 = create_image_watermark("#{Rails.root}/app/assets/images/demo (1).jpg","Adler",\
          "Black",params[:name],30)
      @watermark.watermark_image = image1
      @slider_value  = @watermark.text_opacity_value
      @watermark.is_default = false
      @find = "yes"
  end

  # GET /watermarks/1/edit
  def edit
  end

  # POST /watermarks
  # POST /watermarks.json
  def create
    @watermark = Watermark.new(watermark_params)
    if params[:watermark][:selected_as].present? && params[:watermark][:selected_as] == "true"
        image1 = create_image_watermark("#{Rails.root}/app/assets/images/demo (1).jpg",params[:watermark][:font_set],\
          params[:watermark][:color],params[:watermark][:text_name],params[:watermark][:text_opacity_value])
        image2 = create_image_watermark("#{Rails.root}/app/assets/images/demo.jpg",params[:watermark][:font_set],\
          params[:watermark][:color],params[:watermark][:text_name],params[:watermark][:text_opacity_value])
        @watermark.watermark_image = image1
        @watermark.watermark_sample_image = image2
        @watermark.is_first = false
      # else
      end

    respond_to do |format|
      if @watermark.save
        format.js
        format.html { redirect_to edit_watermark_path(@watermark.id,create: "create"), notice: 'Watermark was successfully created.' }
        format.json { render :show, status: :created, location: @watermark }
      else
        format.js
        format.html { render :new }
        format.json { render json: @watermark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watermarks/1
  # PATCH/PUT /watermarks/1.json
  def update
    puts "===============#{params.inspect}=================="
    respond_to do |format|
      if @watermark.update(watermark_params)
        if params[:watermark][:selected_as].present? || params[:watermark][:name].present?
          format.js
          format.html { redirect_to edit_watermark_path(@watermark.id), notice: 'The watermark settings have been saved.' }
        else
          format.js
          format.html { redirect_to watermarks_url}
        end
        format.json { render :show, status: :ok, location: @watermark }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @watermark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watermarks/1
  # DELETE /watermarks/1.json
  def destroy
    @watermark.destroy
    respond_to do |format|
      format.html { redirect_to watermarks_url, notice: 'Watermark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def apply_default
    @brands = Brand.find(current_brand.id)
    if @brands.update_attributes(:apply_watermark => params[:completed] == "true" ? true : false)
      flash[:notice] = 'Successfully checked in'
      render :nothing => true
    else
      render :nothing => true
    end
  end
  def default_set
    Watermark.update_all(:is_default => nil)
    @watermark = Watermark.find(params[:watermark_id])
    if @watermark.update_attributes(:is_default => true)
      flash[:notice] = 'Watermark set as default watermark'
      render :nothing => true
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watermark
      @watermark = Watermark.find(params[:id])
    end
    def set_text_name
      @watermark = Watermark.find(params[:id])
      @set_text_name = @watermark.text_name ? "My Studio Name" : @watermark.text_name
      if @watermark.text_opacity_value
        @slider_value  = @watermark.text_opacity_value
      else
        @slider_value = 14
      end
      if @watermark.size
        @slider_value2  = @watermark.size
      else
        @slider_value2 = 14
      end
      if @watermark.image_opacity_value
        @slider_value3  = @watermark.image_opacity_value
      else
        @slider_value3 = 14
      end
    end
    def set_watermark_image
      if params[:remove_all]
        Watermark.update_all(:is_default => nil)
      end
      @watermark = Watermark.find(params[:id])
      if params[:watermark][:selected_as].present? && params[:watermark][:selected_as] == "true"
        image1 = create_image_watermark("#{Rails.root}/app/assets/images/demo (1).jpg",params[:watermark][:font_set],\
          params[:watermark][:color],params[:watermark][:text_name],params[:watermark][:text_opacity_value])
        image2 = create_image_watermark("#{Rails.root}/app/assets/images/demo.jpg",params[:watermark][:font_set],\
          params[:watermark][:color],params[:watermark][:text_name],params[:watermark][:text_opacity_value])
        @watermark.watermark_image = image1
        @watermark.watermark_sample_image = image2
        @watermark.is_first = false
      # else
      end
    end
    def set_image
      puts @watermark.selected_as.present?
      if @watermark.selected_as != nil && @watermark.selected_as == false
        image1 = create_watermark_image(@watermark.avatar.path,"#{Rails.root}/app/assets/images/demo (1).jpg",\
          @watermark.size,@watermark.image_placement)
        image2 = create_watermark_image(@watermark.avatar.path,"#{Rails.root}/app/assets/images/demo.jpg",\
          @watermark.size,@watermark.image_placement)
        @watermark.watermark_image = image1
        @watermark.watermark_sample_image = image2
        @watermark.is_first = false
        @watermark.save!
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def watermark_params
      params.require(:watermark).permit(:name, :text_name, :font_set, :color, :text_opacity_value, :image_url, :image_placement, :size, :image_opacity_value, :selected_as, :is_default,:is_first, :brand_id,:avatar,:watermark_image,:watermark_sample_image)
    end
end
