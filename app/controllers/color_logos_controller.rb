class ColorLogosController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_color_logo, only: [:show, :edit, :update, :destroy]
  layout false, only: :mobile_iframe
  # GET /color_logos
  # GET /color_logos.json
  def index
    if @current_user_permissions.find_by(permission_name: "View Color and Logos").value == false
      @not_authorized = true
    end
    if @current_user_permissions.find_by(permission_name: "Add Color and Logos").value == false
      @not_authorized_to_add = true
    end
    @color_logos = current_brand.color_logos.all
    @color_logo = ColorLogo.new
  end

  # GET /color_logos/1
  # GET /color_logos/1.json
  def show
  end

  # GET /color_logos/new
  def new
    if @current_user_permissions.find_by(permission_name: "Add Color and Logos").value == false
      @not_authorized = true
      redirect_to color_logos_path
    end
    @color_logo = ColorLogo.new
  end

  # GET /color_logos/1/edit
  def edit
    @default_gallery_layout = current_brand.gallery_layouts.where(color_logo_id: params[:id])
    @g_l_c = @default_gallery_layout.count
    @home_page = StudioHomePage.where(color_logo_id: params[:id])
    @h_p_c = @home_page.count
    @custom_gallery_layout = CustomGalleryLayout.where(color_logo_id: params[:id])
    @c_g_l_c = @custom_gallery_layout.count
    @galleries = current_brand.galleries.where(id: @custom_gallery_layout.map(&:gallery_id)).to_a
    @nope = @g_l_c || @h_p_c || @c_g_l_c

  end

  # POST /color_logos
  # POST /color_logos.json
  def create
    @color_logo = ColorLogo.new(color_logo_params)
    respond_to do |format|
      if @color_logo.save
        format.html { redirect_to edit_color_logo_path(@color_logo), notice: 'Color logo was successfully created.' }
        format.json { render :show, status: :created, location: @color_logo }
      else
        if params[:color_logo][:name] == ''
          format.html { redirect_to color_logos_path(theme: params[:color_logo][:theme]), flash: {errorforname: 'Color logo name could not be created'} }
          format.json { render json: @color_logo.errors, status: :unprocessable_entity }
        else
          format.html { redirect_to color_logos_path(name: params[:color_logo][:name]), flash: {errorfortheme: 'Color logo theme could not be created'} }
          format.json { render json: @color_logo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /color_logos/1
  # PATCH/PUT /color_logos/1.json
  def update

    if @current_user_permissions.find_by(permission_name: "Edit Color and Logos").value == false
      @not_authorized = true
      render( :edit)
    else
      if (params[:color_logo][:hidden_email_logo_remove] == "true")
        params[:color_logo][:email_logo] = nil
        @color_logo.email_logo.destroy
      end
      if (params[:color_logo][:hidden_remove] == "true" )
        params[:color_logo][:gallery_logo] = nil
        @color_logo.gallery_logo.destroy
      end
      if params[:color_logo][:primary_color] == ''
        respond_to do |format|
          format.html { redirect_to edit_color_logo_path(id: params[:id]), flash: {errorforprimarycolor: 'Value can not be empty'} }
          format.json { render json: @color_logo.errors, status: :unprocessable_entity }
        end
      elsif params[:color_logo][:secondary_color] == ''
        respond_to do |format|
          format.html { redirect_to edit_color_logo_path(id: params[:id]), flash: {errorforsecondarycolor: 'Value cannot be empty'} }
          format.json { render json: @color_logo.errors, status: :unprocessable_entity }
        end
      else
        respond_to do |format|
          if @color_logo.update(color_logo_params)
            format.html { redirect_to color_logos_path, notice: 'Color logo was successfully updated.' }
            format.json { render :show, status: :ok, location: @color_logo }
          else
            format.html { render :edit }
            format.json { render json: @color_logo.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # DELETE /color_logos/1
  # DELETE /color_logos/1.json
  def destroy
    @color_logo.destroy
    respond_to do |format|
      format.html { redirect_to color_logos_url, notice: 'Color logo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

def mobile_iframe

end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color_logo
      @color_logo = ColorLogo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_logo_params
      params.require(:color_logo).permit(:name, :font_set, :theme, :primary_color, :secondary_color, :gallery_logo, :email_logo).merge(brand_id: current_brand.id)
    end
end
