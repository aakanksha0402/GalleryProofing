class GalleryLayoutsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_gallery_layout, only: [:show, :edit, :update, :destroy]

  # GET /gallery_layouts
  # GET /gallery_layouts.json
  def index
    if @current_user_permissions.find_by(permission_name: "View Default Gallery Settings").value == false
      @not_authorized = true
    end
    if @current_user_permissions.find_by(permission_name: "Add Default Gallery Settings").value == false
      @not_authorized_to_add = true
    end
    @gallery_layouts = current_brand.gallery_layouts.all
    @gallery_layout = GalleryLayout.new
  end

  # GET /gallery_layouts/1
  # GET /gallery_layouts/1.json
  def show
  end
  def addset
    @gallery_layout = GalleryLayout.new
  end
  def layoutlist
    @gallery_layouts = current_brand.gallery_layouts.all
  end
  def update
    @gallery_layout=GalleryLayout.find(current_user.id)
  end

  # GET /gallery_layouts/new
  def new
    if @current_user_permissions.find_by(permission_name: "Add Default Gallery Settings").value == false
      redirect_to gallery_layouts_path
    end
    @gallery_layout = GalleryLayout.new
  end

  # GET /gallery_layouts/1/edit
  def edit

    @gallery_layout=GalleryLayout.find_by(id: params[:id])
  end

  def set_default
    @gallery_layout_all=GalleryLayout.where(brand_id: current_brand.id).update_all(is_default: false)
    @set = GalleryLayout.where(id: params[:id]).update_all(is_default: true)
    puts @set.as_json
    redirect_to gallery_layouts_path
  end

  # POST /gallery_layouts
  # POST /gallery_layouts.json
  def create
    @gallery_layout = GalleryLayout.new(gallery_layout_params)
    respond_to do |format|
      if @gallery_layout.save
        format.html { redirect_to edit_gallery_layout_path(id: @gallery_layout.id), notice: 'Gallery layout was successfully created.' }
        format.json { render :show, status: :created, location: @gallery_layout }
      else
        format.html { render :new }
        format.json { render json: @gallery_layout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gallery_layouts/1
  # PATCH/PUT /gallery_layouts/1.json
  def update
    if @current_user_permissions.find_by(permission_name: "Edit Default Gallery Settings").value == false
      @not_authorized = true
      render ( :edit)
    else
      @gallery=GalleryLayout.find_by(id: params[:id])
      respond_to do |format|
        if @gallery_layout.update(gallery_layout_params)
          format.html { redirect_to gallery_layouts_path, notice: 'Gallery layout was successfully updated.' }
          format.json { render :show, status: :ok, location: @gallery_layout }
        else
          format.html { render :edit }
          format.json { render json: gallery_layouts_layoutlist_path.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /gallery_layouts/1
  # DELETE /gallery_layouts/1.json
  def destroy
    @gallery_layout.destroy
    respond_to do |format|
      format.html { redirect_to gallery_layouts_url, notice: 'Gallery layout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery_layout
      @gallery_layout = GalleryLayout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_layout_params
      params.require(:gallery_layout).permit(:name, :introduction_page_layout, :photo_page_layout, :status, :custom_link, :gallery_access_privacy, :password, :email_require, :cropping, :preregistration, :black_and_white_filtering, :studio_link, :show_filename, :social_sharing_link, :content, :min_order, :add_photo_to_cart, :pay_later, :pickup_option, :checkout_message, :digital_download, :entire_gallery_download, :hide_photos, :archiving, :pricing_id,:visitor_info,:automation_series_id,:is_default,:color_logo_id,:category_id).merge(brand_id: current_brand.id,user_id: current_user.id)
    end
end
