class DashboardsController < ApplicationController
  # before_filter :authenticate_user!
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]


  # GET /dashboards
  # GET /dashboards.json
  def index
    if user_signed_in?
      @dashboard = current_user.dashboard
      @galleries = current_brand.galleries.where(is_delete: false)
      if @dashboard.add_gallery == false && @galleries.count > 0
        @dashboard.update(add_gallery: true)
      end
      @photos = Photo.where("imageable_id IN(?) AND imageable_type = ?", @galleries.pluck(:id), "Gallery")
      if @dashboard.upload_photos == false && @photos.count > 0
        @dashboard.update(upload_photos: true)
      end
      @watermark = current_brand.watermarks.where(is_first: false)
      if @dashboard.customize_watermark == false && @watermark.present?
        @dashboard.update(customize_watermark: true)
      end
      @color_logo = current_brand.color_logos.first
      if @color_logo.updated_at > @color_logo.created_at
        @color_logo_present = true
        if @dashboard.setup_colo_logo == false && @color_logo_present == true
          @dashboard.update(setup_colo_logo: true)
        end
      end
      @notifications = current_brand.notifications.where(is_dismiss: false).limit(4)
      @gallery = @galleries.limit(4)
    end
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def dismiss
    if params[:video].present?
      @dashboard = current_user.dashboard.update(show_video: false)
    elsif params[:get_paid].present?
      @dashboard = current_user.dashboard.update(show_get_paid: false)
    end
  end

  def recent_gallery_activity
    @galleries = current_brand.galleries.where(is_delete: false)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params.require(:dashboard).permit(:show_video, :add_gallery, :upload_photos, :customize_watermark, :setup_colo_logo, :user_id, :show_get_paid)
    end
end
