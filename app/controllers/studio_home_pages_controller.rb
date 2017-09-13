class StudioHomePagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_studio_home_page, only: [:show, :edit, :update, :destroy]

  # GET /studio_home_pages
  # GET /studio_home_pages.json
  def index
    if @current_user_permissions.find_by(permission_name: "Edit HomePage").value == false
      @not_authorized = true
    end
    @studio_home_page = current_brand.studio_home_page
    # $subdomain = @studio_home_page.subdomain
    $subdomain = current_brand.id
  end

  # GET /studio_home_pages/1
  # GET /studio_home_pages/1.json
  def show
    render :index
  end

  # GET /studio_home_pages/new
  def new
    @studio_home_page = StudioHomePage.new
  end

  # GET /studio_home_pages/1/edit
  def edit
  end

  # POST /studio_home_pages
  # POST /studio_home_pages.json
  def create
    @studio_home_page = StudioHomePage.new(studio_home_page_params)

    respond_to do |format|
      if @studio_home_page.save
        format.html { redirect_to @studio_home_page, notice: 'Studio home page was successfully created.' }
        format.json { render :show, status: :created, location: @studio_home_page }
      else
        format.html { render :new }
        format.json { render json: @studio_home_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /studio_home_pages/1
  # PATCH/PUT /studio_home_pages/1.json
  def update
    if @current_user_permissions.find_by(permission_name: "Edit HomePage").value == false
      @not_authorized = true
      render( :index)
    else
      respond_to do |format|
        if @studio_home_page.update(studio_home_page_params)
          format.html { redirect_to studio_home_pages_path, notice: 'Studio home page was successfully updated.' }
          format.json { render :index, status: :ok, location: @studio_home_page }
        else
          format.html { render :index }
          format.json { render json: @studio_home_page.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /studio_home_pages/1
  # DELETE /studio_home_pages/1.json
  def destroy
    @studio_home_page.destroy

    @color_logo_id = @studio_home_page.color_logo_id
    @color_logo = ColorLogo.find(@color_logo_id.id)
    @color_logo.destroy
    respond_to do |format|
      format.html { redirect_to studio_home_pages_url, notice: 'Studio home page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def view
    render layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_studio_home_page
      @studio_home_page = StudioHomePage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def studio_home_page_params
      params.require(:studio_home_page).permit(:subdomain, :color_logo_id, :homepage_layout, :event_list, :email_field, :sort_on, :about, :fb_url, :twitter_username, :intagram_username, :pinterest_username, :show_about, :show_phone, :show_address, :show_email, :show_website_link).merge(brand_id: current_brand.id)
    end
end
