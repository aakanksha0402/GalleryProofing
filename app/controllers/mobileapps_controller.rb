class MobileappsController < ApplicationController
  before_action :set_mobileapp, only: [:show, :edit, :update, :set_icon,:destroy,:change_icon,:add_photos,:save_photos,:add_link,:add_theme,:share_link,:save_share_link]
  before_action :find_gallery, only: [:index,:edit]
  before_action :find_photo, only: [:delete_image]
  before_action :find_link, only: [:update_link,:delete_link]
  before_filter :authenticate_user!, except: [:show_app]
  # GET /mobileapps
  # GET /mobileapps.json
  def index
    @mobileapps = Mobileapp.where(:brand_id => current_brand.id)
    @mobileapps = @mobileapps.mobileapp_name(params[:app_name]) if params[:app_name].present?
    if params[:gallery_find].present?
      @mobileapps = @mobileapps.gallery_find(params[:gallery_find])
      @gallery_name = Gallery.find(params[:gallery_find])
    end

    @mobileapp = Mobileapp.new
    @view_type = current_user.mobile_view_type

    # @mobileapp= Mobileapp.new
    # if @mobileapp.photo_id.present?
    #   @find_pic = @mobileapp.photos.find(@mobileapp.photo_id)
    # end
  end
  # def change_icon
  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end
  # GET /mobileapps/1
  # GET /mobileapps/1.json
  def show
  end

  # GET /mobileapps/new
  def new
    @mobileapp = Mobileapp.new
  end

  # GET /mobileapps/1/edit
  def edit
    @color_logo = ColorLogo.where(:brand_id => current_brand.id)
    if @mobileapp.photo_id.present?
      @find_pic = @mobileapp.photos.find(@mobileapp.photo_id)
      # puts "---------------#{@find_pic.inspect}--------"
    end
  #   if @mobileapp.color_logo_id.present?
  #    @color_logo_theme = ColorLogo.find(@mobileapp.color_logo_id)
  #  end

  end

  # POST /mobileapps
  # POST /mobileapps.json
  def create
    @mobileapp = Mobileapp.new(mobileapp_params)

    respond_to do |format|
      if @mobileapp.save
        @created = true
          if params[:mobile_app_photo].present?
            params[:mobile_app_photo].split(",").each do |mobile_app_photo|
                @find_image =  Photo.find(mobile_app_photo)
                @mobileapp.photos.new.image = @find_image.image
            end
          @mobileapp.save
        end

        format.js
        format.html { redirect_to mobileapps_path, notice: 'Mobileapp was successfully created.' }
        format.json { render :show, status: :created, location: @mobileapp }
      else
        @created = false
        format.js
        format.html { render :new }
        format.json { render json: @mobileapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobileapps/1
  # PATCH/PUT /mobileapps/1.json
  def update
    puts "++++++++++++++___________________________#{params.inspect}____________________++++++++++++"
    puts params[:commit]
    respond_to do |format|
      unless params[:commit] == "Choose Gallery"
        if params[:image_id].present?
          @mobileapp.update(:photo_id =>  params[:image_id])
          params[:mobileapp][:logo] = nil
        else
          @mobileapp.update(:photo_id => nil)
        end
      end
      if @mobileapp.update(mobileapp_params)
        if !@mobileapp.logo_file_name.nil? && !params[:mobileapp][:crop_x].blank?
          @mobileapp.logo.reprocess!
        end
        format.html { redirect_to edit_mobileapp_path(@mobileapp), notice: 'Mobileapp was successfully updated.' }
        format.json { render :show, status: :ok, location: @mobileapp }
      else
        format.html { render :edit }
        format.json { render json: @mobileapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobileapps/1
  # DELETE /mobileapps/1.json
  def destroy
    @mobileapp.destroy
    respond_to do |format|
      format.html { redirect_to mobileapps_url, notice: 'Mobileapp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def share_link
    if params[:default_template_id].present?
      @default_template = DefaultEmailTemplate.find(params[:default_template_id])
    else
      @default_template = DefaultEmailTemplate.find(2)
    end
    @default_template.email_subject = params[:subject_change] if params[:subject_change]
    @default_template.headline = params[:headline_change] if params[:headline_change]
    @default_template.button_text = params[:buttontext] if params[:buttontext]
    @default_template.email_body = params[:message].gsub(/(\r)?\n/, '<br />') if params[:message]

    @mobileapp_share = MobileappShare.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  def save_share_link
    @mobileapp_share = MobileappShare.new(mobileapp_share_params)
    respond_to do |format|
      if @mobileapp_share.save
        if params[:from] == "edit"
          format.html { redirect_to edit_mobileapp_path(@mobileapp), notice: 'Email was successfully sent.' }
          format.json { render :show, status: :created, location: @mobileapp }
        else
          format.html { redirect_to mobileapps_path, notice: 'Email was successfully sent.' }
          format.json { render :show, status: :created, location: @mobileapp }
        end
        MobileappMailer.mobileapp_email(@mobileapp_share,current_brand.brand_name,current_brand.id,@mobileapp).deliver_now
      else
        format.html { render :new }
        format.json { render json: @mobileapp.errors, status: :unprocessable_entity }
      end
    end
  end
  def delete_image
    @mobileapp.photo_id == @photo.id ? @photo.update(is_delete: true) : @photo.destroy
    respond_to do |format|
      format.html { redirect_to edit_mobileapp_path(@mobileapp), notice: 'Mobileapp Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_theme
    if params[:color_logo_id].present?
      @mobileapp.update(:color_logo_id => params[:color_logo_id])
    end
    if params[:contact_info].present?
      @mobileapp.update(:contact_info => params[:contact_info] )
    end
    if params[:social_sharing].present?
      @mobileapp.update(:social_sharing => params[:social_sharing] )
    end
    if params[:language].present?
      @mobileapp.update(:language => params[:language] )
    end
    if params[:layout].present?
      @mobileapp.update(:layout => params[:layout] )
    end
      render :nothing => true
  end

  def add_photos
    # @mobileapp_photos = @mobileapp.mobileapp_photos.new
    @mobileapp_photos = @mobileapp.photos.new
  end

  def set_icon
    if params[:image_id].present?
      photo =  Photo.find(params[:image_id]).image
      if @mobileapp.update(:photo_id =>  nil, logo: photo,crop_x: params[:crop_x],crop_y: params[:crop_y],crop_w: params[:crop_w],crop_h: params[:crop_h])
        if !@mobileapp.logo_file_name.nil? && !params[:crop_x].blank?
          @mobileapp.logo.reprocess!
        end
      end
    else
      @find_mobile_app.update(:photo_id => nil)
    end
    @photo_url= Photo.find(params[:image_id]).image.url
    @find_mobile_app = Mobileapp.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def save_photos
    puts "(((((((((((((((())))))))))))))))#{params.inspect}((((((((((((((()))))))))))))))"
    @photo_array = Array.new
    # params[:mobileapp][:mobileapp_photo][:photo].each do |image|
      params[:mobileapp][:photo][:photo].each do |image|
        puts image.inspect
        puts "njkhujhjkhjkuiuiuyiu"
        @photo_array << image.original_filename
      end

      # puts "#{@photo_array}"

      @mobileapp = Mobileapp.find(params[:id])
      @photos = @mobileapp.photos.pluck(:image_file_name)

      #  @context = context
       puts "****#{@context.inspect}****"
       puts "****#{@mobileapp.inspect}****"
      fileExtension = ['jpeg', 'jpg']
      # filename = []
      # params[:gallery][:photo][:image].each do |filenames|
      #   unless filename.include?filenames.original_filename.split('.').first
      #     filename << filenames
      #   end
      # end
      # puts filename
      params[:mobileapp][:photo][:photo].each do |p|
      # puts p.original_filename.split('.').last
      if fileExtension.include?p.original_filename.split('.').last
        unless @photos.include?(p.original_filename)
          # @photo = photos.build
          @photo = @mobileapp.photos.build
          @photo.image = p
          @photo.save!
        end
      end
    end
      redirect_to edit_mobileapp_path(@mobileapp), notice: "The link has been successfully created."


    # fileExtension = ['jpeg', 'jpg']
    # params[:mobileapp][:mobileapp_photo][:photo].each do |p|
    #   # puts p.original_filename.split('.').last
    #   if fileExtension.include?p.original_filename.split('.').last
    #     @image = @mobileapp.mobileapp_photos.build
    #     @image.photo = p
    #     @image.save!
    #   end
    # end
    #   redirect_to edit_mobileapp_path(@mobileapp), notice: "The photo has been successfully created."
  end

  def add_link
    @photo_link = @mobileapp.mobileapp_custom_links.build
    @photo_link.link = params[:mobileapp][:mobileapp_custom_links][:link]
    @photo_link.logo = params[:mobileapp][:mobileapp_custom_links][:logo]
    if @photo_link.save!
      redirect_to edit_mobileapp_path(@mobileapp), notice: "The link has been successfully created."
    end
  end

  def change_view_type
    puts params
    current_user.update(mobile_view_type: params[:view_type])
  end

  def update_link
    if @custom_link.update(:link => params[:link])
      redirect_to edit_mobileapp_path(@mobileapp), notice: "The link has been successfully updated."
    end
  end
  def delete_link
    @custom_link.destroy
    respond_to do |format|
      format.html { redirect_to edit_mobileapp_path(@mobileapp), notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_app
    @mobileapp = Mobileapp.find(params[:mobileapp_id])
    @brand = Brand.find(params[:brand_id])
  end

  def layout_language_mobile
    puts "============#{params.inspect}............"

    @mobileapp_update  = Mobileapp.find(params[:mobileapp_id])

     if (params[:layout].present?)
         @mobileapp_update.update(layout: params[:layout])
     end
    if(params[:language].present?)
      @mobileapp_update.update(language: params[:language])
    end

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobileapp
      @mobileapp = Mobileapp.find(params[:id])
    end
    #all gallery associated with it
    def find_gallery
      @gallery = Gallery.where(:brand_id => current_brand.id)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def mobileapp_share_params
      params.require(:mobileapp_share).permit(:mobileapp_id,:recipient,:email_template_id,:subject,:headline,:buttontext,:message)
    end
    def mobileapp_params
      params.require(:mobileapp).permit(:name, :contact_info, :social_sharing, :layout, :language, :mobileapp_photo_id, :color_logo_id, :mobileapp_custom_link_id, :gallery_id,:brand_id,:logo,:crop_x, :crop_y, :crop_w, :crop_h)
    end
    def find_photo
      @photo = Photo.find(params[:image_id])
      puts "hello#{@photo.inspect}hello"
      @mobileapp = Mobileapp.find(params[:mobileapp_id])
    end
    def find_link
      @mobileapp = Mobileapp.find(params[:mobileapp_id])
      @custom_link = MobileappCustomLink.find(params[:customlink_id])
    end

    def context
      if params[:mobileapp_id]
        id = params[:mobileapp_id]
        @name =  Mobileapp.find(params[:gallery_id])
      else
          redirect_to edit_mobileapp
      end
    end
end
