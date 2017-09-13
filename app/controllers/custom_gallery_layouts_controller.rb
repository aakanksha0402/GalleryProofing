class CustomGalleryLayoutsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_custom_gallery_layout, only: [:show, :edit, :update, :destroy]

  # GET /custom_gallery_layouts
  # GET /custom_gallery_layouts.json
  def index
    @custom_gallery_layouts = CustomGalleryLayout.all
  end

  # GET /custom_gallery_layouts/1
  # GET /custom_gallery_layouts/1.json
  def show
  end

  # GET /custom_gallery_layouts/new
  def new
    @custom_gallery_layout = CustomGalleryLayout.new
  end

  # GET /custom_gallery_layouts/1/edit
  def edit
    @gallery = @custom_gallery_layout.gallery
  end

  # POST /custom_gallery_layouts
  # POST /custom_gallery_layouts.json
  def create
    @custom_gallery_layout = CustomGalleryLayout.new(custom_gallery_layout_params)

    respond_to do |format|
      if @custom_gallery_layout.save
        # @galleries = Gallery.where(id: @gallery1).update_all(status: params[:galleries])
        format.html { redirect_to @custom_gallery_layout, notice: 'Custom gallery layout was successfully created.' }
        format.json { render :show, status: :created, location: @custom_gallery_layout }
      else
        format.html { render :new }
        format.json { render json: @custom_gallery_layout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_gallery_layouts/1
  # PATCH/PUT /custom_gallery_layouts/1.json
  def update
    respond_to do |format|
      puts params
        @custom_update = @custom_gallery_layout.update(custom_gallery_layout_params)
        @gallery = current_brand.galleries.find(@custom_gallery_layout.gallery_id)
        # puts Date.new(params[:custom_gallery_layout][:gallery]["shoot_date(1i)"].to_i,params[:custom_gallery_layout][:gallery]["shoshoot_date(2i)"].to_i,params[:custom_gallery_layout][:gallery]["shoot_date(3i)"].to_i)

        if params[:custom_gallery_layout][:gallery][:release_date].present? && params[:custom_gallery_layout][:gallery][:expiration_date].present?
          @gallery_update = @gallery.update_attributes(status: params[:custom_gallery_layout][:gallery][:status],custom_link: params[:custom_gallery_layout][:gallery][:custom_link],shoot_date: Date.strptime(params[:custom_gallery_layout][:gallery][:shoot_date], '%d/%m/%Y'),release_date: Date.strptime(params[:custom_gallery_layout][:gallery][:release_date], '%d/%m/%Y'),expiration_date: Date.strptime(params[:custom_gallery_layout][:gallery][:expiration_date], '%d/%m/%Y'))
        elsif params[:custom_gallery_layout][:gallery][:release_date].present?
          @gallery_update = @gallery.update_attributes(status: params[:custom_gallery_layout][:gallery][:status],custom_link: params[:custom_gallery_layout][:gallery][:custom_link],shoot_date: Date.strptime(params[:custom_gallery_layout][:gallery][:shoot_date], '%d/%m/%Y'),release_date: Date.strptime(params[:custom_gallery_layout][:gallery][:release_date], '%d/%m/%Y'))
        elsif params[:custom_gallery_layout][:gallery][:expiration_date].present?
          @gallery_update = @gallery.update_attributes(status: params[:custom_gallery_layout][:gallery][:status],custom_link: params[:custom_gallery_layout][:gallery][:custom_link],shoot_date: Date.strptime(params[:custom_gallery_layout][:gallery][:shoot_date], '%d/%m/%Y'),expiration_date: Date.strptime(params[:custom_gallery_layout][:gallery][:expiration_date], '%d/%m/%Y'))
        else
          @gallery_update = @gallery.update_attributes(status: params[:custom_gallery_layout][:gallery][:status],custom_link: params[:custom_gallery_layout][:gallery][:custom_link],shoot_date: Date.strptime(params[:custom_gallery_layout][:gallery][:shoot_date], '%d/%m/%Y'))
        end

        if params[:custom_gallery_layout][:gallery][:custom_link].present?
          @gallery.slug = nil
          @gallery.save
        end

        if @custom_update && @gallery_update
          format.html { redirect_to galleries_galleryhome_path(id: @custom_gallery_layout.gallery_id), notice: 'Custom gallery layout was successfully updated.' }
          format.json { render :show, status: :ok, location: @custom_gallery_layout }
        else
          @used_custom_link=Gallery.find_by(custom_link: params[:custom_gallery_layout][:gallery][:custom_link])
          puts "____________________________"
          format.html { render :edit , flash: {notice1: 'The custom event URL chosen is already in use by the event'}}
          format.json { render json: @custom_gallery_layout.errors, status: :unprocessable_entity }
        end
    end
  end

  # DELETE /custom_gallery_layouts/1
  # DELETE /custom_gallery_layouts/1.json
  def destroy
    @custom_gallery_layout.destroy
    respond_to do |format|
      format.html { redirect_to custom_gallery_layouts_url, notice: 'Custom gallery layout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_gallery_layout
      @custom_gallery_layout = CustomGalleryLayout.includes(:gallery).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_gallery_layout_params
      params.require(:custom_gallery_layout).permit(:layout_name, :introduction_page_layout, :photo_page_layout, :gallery_access_privacy, :password, :email_require, :cropping, :preregistration, :black_and_white_filtering, :studio_link, :show_filename, :social_sharing_link, :content, :min_order, :add_photo_to_cart, :pay_later, :pickup_option, :checkout_message,:digital_download, :entire_gallery_download, :hide_photos, :archiving,  :pricing_id, :visitor_info, :automation_series_id,:is_default,:color_logo_id, :category_id,:require_PIN,:PIN)
    end
end
