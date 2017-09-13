require 'RMagick'
require 'watermark_image'
class GalleriesController < ApplicationController
  include WatermarkImage
  protect_from_forgery except: :index

  before_filter :authenticate_user!
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  before_action :set_watermark, only: [:create_watermark]
  helper_method :sort_column, :sort_direction, :sort_column_status
  require 'json'

  # GET /galleries
  # GET /galleries.json
  def index
    if @current_user_permissions.find_by(permission_name: 'View Galleries').value == false
      @not_authorized = true
    end
    if @current_user_permissions.find_by(permission_name: 'Add Galleries').value == false
      @not_authorized_to_add = true
    end
    if @current_user_permissions.find_by(permission_name: 'View Default Gallery Settings').value == false
      @not_authorized_to_view_default_settings = true
    end
    if @current_user_permissions.find_by(permission_name: 'Delete Edit Galleries').value == false
      @not_authorized_to_delete = true
    end
    @tag = if params[:status].present?
      params[:status]
    else
      'All Open'
    end
    @current_subdomain = current_brand.id

    # @current_subdomain = current_brand.studio_home_page.subdomain
    @gallery_share = GalleryShare.new
    @gallery_new = Gallery.new
    @galleries_main = current_brand.galleries.all.order(sort_column + ' ' + sort_direction)
    @galleries = current_brand.galleries.where(is_delete: false).order(sort_column + ' ' + sort_direction)
    @galleries1 = CustomGalleryLayout.where(gallery_id: @galleries.ids)

    @galleries = @galleries.gallery_name(params[:search]) if params[:search].present?
    @galleries = @galleries.gallery_shoot_date(params[:shoot_date]) if params[:shoot_date].present?
    if params[:status].present?
      if params[:status] == 'Pre-registered'
        @galleries = @galleries.gallery_preregistered(params[:status])
      elsif params[:status] == 'Archived'
        @galleries = @galleries.gallery_archived(params[:status])
      else
        @galleries = @galleries.gallery_status(params[:status])
      end
    end

    @photos = Photo.all

    puts '*****************'
    if params[:gallery_access_privacy].present?
      puts params[:gallery_access_privacy].downcase.gsub(/\W/, '_')
    end
    puts '*****************'

    @galleries = @galleries.gallery_access_privacy(params[:gallery_access_privacy].downcase.gsub(/\W/, '_')) if params[:gallery_access_privacy].present?
    @cgl = CustomGalleryLayout.where(user_id: current_user.id).joins(:gallery).order(sort_column_status + ' ' + sort_direction)
    @gallery = Gallery.new
    if params[:id].present?
      respond_to do |format|
        format.js
      end
    end
    #@hidden_photos = Photo.where('(imageable_id IN(?) OR imageable_id IN(?)) AND is_delete = false ', @gallery.id, @find_album).where('is_hidden = ? ', true)
    #puts "******boss******#{@gallery.inspect}++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #@hidden_photos = @gallery.photos_with_albums.where('is_delete = false').where('is_hidden = ? ', true)
    #puts "*=******************************#{@hidden_photos}**"
    @default_layout = current_brand.gallery_layouts.find_by(is_default: true)
    @view_type = current_user.view_type
    # @photos_count = GalleryPhoto.where(gallery_id: current_brand.galleries.ids).count
    @categories = current_brand.categories

    @current_brand = current_brand
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
  end

  def bulkaction
    puts params[:gallery_ids]
    @gallery_new = Gallery.new
    @g = Gallery.where(id: params[:gallery_ids])
    @gallery = current_brand.galleries.all
  end

  def share_details
    @current_brand = current_brand
    if params[:id].present?
      @gallery_cover_url = Gallery.find_by(id: params[:id])
    else
      @gallery_cover_url = Gallery.find_by(id: params[:gallery_share][:gallery_id])
    end

    params[:recipient].split(',').each do |email|
      if email == '' || email == ' '
      else
        if params[:id].present?
          @gallery_share_details = GalleryShare.new(recipient: email, email_template_id: params[:gallery_share][:email_template_id], subject: params[:gallery_share][:subject], headline: params[:gallery_share][:headline], buttontext: params[:gallery_share][:buttontext], message: params[:gallery_share][:message], gallery_id: params[:id])
        else
          @gallery_share_details = GalleryShare.new(recipient: email, email_template_id: params[:gallery_share][:email_template_id], subject: params[:gallery_share][:subject], headline: params[:gallery_share][:headline], buttontext: params[:gallery_share][:buttontext], message: params[:gallery_share][:message], gallery_id: params[:gallery_share][:gallery_id])
        end
        @gallery_share_details.save
        GalleryShareMailer.gallery_share_mailer(@gallery_share_details, @current_brand).deliver_now
      end
    end
    redirect_to galleries_path
  end

  def galleryhome
    # @current_subdomain = current_brand.studio_home_page.subdomain
    puts request.referer
    puts "***********************"


    @current_subdomain = current_brand.id
    puts "current_brand: #{@current_subdomain}"
    if @current_user_permissions.find_by(permission_name: 'View Galleries').value == false
      @not_authorized = true
      redirect_to galleries_path
    end
    if @current_user_permissions.find_by(permission_name: 'Add Photos within Galleries').value == false
      @not_authorized = true
    end
    if @current_user_permissions.find_by(permission_name: 'Edit Galleries').value == false
      @not_authorized_to_edit = true
    end

    @gallery_share = GalleryShare.new
    @gallery = Gallery.new

    @find_gallery = current_brand.galleries.includes(:albums).find(params[:id])

    # @gallery_photos = GalleryPhoto.where(gallery_id: params[:id]).order(:photo_file_name)
    @p = @find_gallery.photos.where("photos.is_delete = ?", false)

    @gallery_photos = @p.order(:image_file_name)
    puts @gallery_photos.ids

    @find_album = @find_gallery.albums.includes(:photos)

    @album_photos = Photo.where("imageable_type = 'Album' AND imageable_id IN(?) AND is_delete = false", @find_album.ids)

    @gallery_photos1 = @find_gallery.photos.limit(4)

    gallery = Gallery.new
    @all_photos1 =  []

    # @all_photos1 = @gallery_photos | @album_photos
    # puts "++++++++++++++#{@all_photos1.inspect}"
    # @all_photos1.each do |file_name|
    #   puts '___________'
    #   puts file_name.as_json
    #   puts '___________'
    # end
    @all_photos = @all_photos1.sort { |a, b| a.image_file_name && b.image_file_name ? a.image_file_name.downcase <=> b.image_file_name.downcase : a.image_file_name ? -1 : 1 }
    # render_to_string(:partial => "allgalleryphotos", locals: {all_photos: @all_photos})
    # render "galleries/allgalleryphotos"

    # @gallery_photos1 = GalleryPhoto.where(gallery_id: params[:id]).limit(4);

    offset = rand(@gallery_photos.count)

    # Rails 4
    @rand_record = @all_photos1.sample(4)

    @custom_gallery_layout = CustomGalleryLayout.find_by(gallery_id: params[:id])

    @gallery_album = Album.where('gallery_id = ? AND parent = ?', params[:id], 0).order('created_at')

    # @album = Album.where(gallery_id: params[:id])
    # @photos = AlbumPhoto.where(album_id: @find_album.map(&:id)).to_a

    @array1 = []
    @c = @find_gallery.albums.where(parent: @gallery_album.pluck(:id))
    @c1 = @find_gallery.albums.where(parent: @c.pluck(:id))
    @c2 = @find_gallery.albums.where(parent: @c1.pluck(:id))

    if @find_gallery.contact_id != ''
      @gallery_contact = current_brand.contacts.find_by(id: @find_gallery.contact_id)
    end
    @album = Album.new
    # @gallery_cover=Gallery.find_by(id: params[:id])

    @albums = Album.where(gallery_id: params[:gallery_id])

      if @find_gallery.gallery_photo_id.present?
          @find_pic = Photo.find(@find_gallery.gallery_photo_id)
        # @find_pic = @find_gallery.photos.find(@find_gallery.gallery_photo_id)
      end

    # @find_pic=GalleryPhoto.find_by(id: @find_gallery.gallery_photo_id)

    @photos_count = @gallery_photos.count + @album_photos.count
    # all watermark of current brand.
    @watermarks = Watermark.where(brand_id: current_brand.id).order('id ASC')
    # default watermark of current brand
    @default = Watermark.where('brand_id = ? AND is_default = ?', current_brand.id, true).first
    @watermark_id = @default.id if current_brand.apply_watermark
    @favorites = Favorite.joins(gallery_visitor: [:gallery]).where('galleries.id = ?', params[:id])

    @mobileapp = Mobileapp.new

    @hidden_photos = @find_gallery.photos_with_albums.where('is_delete = false').where('is_hidden = ? ', true)

  end

  def create_watermark
    respond_to do |format|
      format.html { redirect_to galleries_galleryhome_path(id: params[:gallery_id]), notice: 'Contact was successfully linked to the gallery.' }
    end
  end

  def hide_album_photos
    puts params
    @find_gallery = current_brand.galleries.includes(:albums).find(params[:id])
    @gallery_photos = @find_gallery.photos.order(:image_file_name)
    if params[:checked] == 'true'
      @all_photos = @gallery_photos
      puts '_______________'
      puts @all_photos.as_json
      puts '_______________'
    else
      @find_album = @find_gallery.albums.includes(:photos)
      @album_photos = Photo.where(imageable_id: @find_album.pluck(:id), imageable_type: 'Album')
      @all_photos1 = @gallery_photos | @album_photos
      @all_photos = @all_photos1.sort { |a, b| a.image_file_name.downcase <=> b.image_file_name.downcase }
      puts '@@@@@@@@@@@@@@@@@@@'
      puts @all_photos.as_json
      puts '@@@@@@@@@@@@@@@@@@@'
    end
    respond_to do |format|
      format.js
    end
  end

  # GET /galleries/new
  def new
    if @current_user_permissions.find_by(permission_name: 'Add Galleries').value == false
      redirect_to galleries_path
    end
    @gallery = Gallery.new
    @list = GalleryLayout.all
    @gallery_layout = GalleryLayout.find_by(user_id: current_user.id)
    @gallery_photo = GalleryPhoto.new
    @custom_gallery_layout = CustomGalleryLayout.new
  end

  def all_delete
    # delete gallery photos
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#{params.inspect}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    @gallery = current_brand.galleries.includes(:albums).find(params[:id])
    puts "================"
     @gallery.photos.update_all(is_delete: true )
     puts "================"

    # @gallery.photos.destroy_all

    # delete album photos
    @gallery.albums.each do |album|
      album.photos.each(&:destroy)
    end
    redirect_to galleries_galleryhome_path(id: params[:id])
  end

  def delete_selected
    puts "______________________________________________"
    @update_photo = Photo.where('id IN (?)',  params[:photo]).update_all(is_delete: true)
    puts "______________________________________________"
    # @delete_photo = Photo.where('id IN (?)',  params[:photo]).destroy_all
    respond_to do |format|
      format.js
    end
  end

  def find_image
    @photo = Photo.find_by_id(params[:id])
    @photo_name = File.basename(@photo.image_file_name, File.extname(@photo.image_file_name))
    @photo_ext = File.extname(@photo.image_file_name)
    puts "_________"
    puts "#{@photo_ext}"
    puts "_________"

  end

  def rename_image
    @rename_image = Photo.find(params[:id])
    @path = File.dirname(@rename_image.image.path)
    @path1 = File.dirname(@rename_image.image.path(:small))
    puts "_______________________"
    puts params[:photo][:image_file_name]+""+File.extname(@rename_image.image_file_name)
    puts @rename_image.image_file_name
    puts @path
    puts @path1
    puts "_______________________"
    File.rename("#{@path}/#{@rename_image.image_file_name}", "#{@path}/#{params[:photo][:image_file_name]}")
    File.rename("#{@path1}/#{@rename_image.image_file_name}", "#{@path1}/#{params[:photo][:image_file_name]}")
    @image_object = @rename_image.update(image_file_name: (params[:photo][:image_file_name]))
  end

  def download_all
    require 'zip/zipfilesystem'

    @gallery = current_brand.galleries.includes(:albums, :photos).find(params[:id])
    @files = @gallery.photos
    puts "------#{@files.inspect}------"
    # @files = GalleryPhoto.where(gallery_id: params[:id])
    @album_id = @gallery.albums
    # @album_id = Album.where(gallery_id: params[:id])

    @files1 = Photo.where('imageable_type = ? AND imageable_id IN(?)', 'Album', @album_id.pluck(:id))
    # @files1 = @album_id.map(&:photos)``

    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @files.each do |file|
        zos.put_next_entry(file.image_file_name)
        zos.print IO.read(file.image.path)
      end
      @files1.each do |file|
        zos.put_next_entry(file.image_file_name)
        zos.print IO.read(file.image.path)
      end
    end

    send_file t.path, type: 'application/zip', filename: 'Photos.zip'
    t.close
  end

  def selected_download
    puts "------------#{params[:id]}+++++++++"
    @photo = Photo.find(params[:photo])
    # send_file "#{Rails.root}/public/#{params[:photo]}", type: 'image/jpeg', disposition: 'attachment'
    send_file @photo.image.path,
              filename: @photo.image_file_name,
              type: @photo.image_content_type,
              disposition: 'attachment'
  end

  def download_all_favorites
    require 'zip/zipfilesystem'
    @photos = Photo.where('id IN (?)', params[:favorite_ids].split(','))
    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @photos.each do |photo|
        zos.put_next_entry(photo.image_file_name)
        zos.print IO.read(photo.image.path)
      end
    end

    send_file t.path, type: 'application/zip', filename: 'Photos.zip'
    t.close
  end

  def addgallery
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  def download
    @photo = Photo.find(params[:photo_id])
    send_file @photo.image.path,
    filename: @photo.image_file_name,
    type: @photo.image_content_type,
    disposition: 'attachment'
    # file_name = params[:feed_image_path].split('/').last
    # send_file "#{Rails.root}/public/#{params[:feed_image_path]}", type: 'image/jpeg', disposition: 'attachment'
  end

  def filelist
    @gallery = current_brand.galleries.includes(:albums, :photos).find(params[:id])
    @gallery_photos = @gallery.photos
    # @gallery_photos = GalleryPhoto.where(gallery_id: params[:id])
    # @galleries = current_brand.galleries.find_by(id: params[:id])
    @find_album = @gallery.albums
    # @find_album = Album.where(gallery_id: params[:id])
    @album_photos = Photo.where('imageable_type = ? AND imageable_id IN (?)', 'Album', @find_album.pluck(:id))
    puts @album_photos
    # @album_photos = AlbumPhoto.where(album_id: @find_album.map(&:id)).to_a
    @photos_count = @gallery_photos.count + @album_photos.count
  end

  def add_link_with_contact
    respond_to do |format|
      @gallery_contact = Gallery.find_by(id: params[:gallery_id])
      @gallery_contact.update(contact_id: params[:id1][:contact_id])
      @gallery_contact.build_privilege.save
      if @gallery_contact
        format.html { redirect_to galleries_galleryhome_path(id: params[:param_id]), notice: 'Contact was successfully linked to the gallery.' }
      end
    end
  end

  # POST /galleries
  # POST /galleries.json
  def create
    puts params
    @gallery = Gallery.new(gallery_params)
    puts params[:gallery][:shoot_date]
    @gallery.shoot_date = params[:gallery][:shoot_date]
    @gl = GalleryLayout.find_by(id: gallery_params[:gallery_layout_id])
    respond_to do |format|
      if @gallery.save
        puts '______________________'
        @gallery.update(shoot_date: params[:gallery][:shoot_date])
        puts '______________________'
        @custom_gallery_layout = CustomGalleryLayout.new(@gl.as_json.except('id', 'status', 'name').deep_merge(gallery_id: @gallery.id, layout_name: @gl.name))
        @custom_gallery_layout.save
        puts "===========================#{@gallery.id}========================"
        format.html { redirect_to galleries_galleryhome_path(id: @gallery.id), notice: 'Gallery was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @gallery }
      else
        if params[:gallery][:name] == ''
          puts 'Empty Name'
          # format.html { redirect_to galleries_path, flash: {errorforname: 'Color logo name could not be created'} }
          format.js
          # format.json { render json: @color_logo.errors, status: :unprocessable_entity }
        else
          format.html { render :new }
          format.json { render json: @gallery.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    @gallery_cover_url = Gallery.find(params[:id])

    @last_gallery_cover_url =  @gallery_cover_url.cover_url
    puts "__________#{@last_gallery_cover_url}_________"
    if params[:gallery][:cover_url].present?
      if ["image/jpeg","image/jpg","image/JPG","image/JPEG"].include? params[:gallery][:cover_url].content_type
        puts "Present"
        @gallery_cover_url.update(cover_url: params[:gallery][:cover_url],gallery_photo_id: nil)
      end
    end


    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to galleries_galleryhome_path(id: params[:id]), notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { redirect_to galleries_galleryhome_path(id: params[:id]) }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.update(is_delete: true)
    respond_to do |format|
      format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_cover_pic
    @gallery = Gallery.find(params[:id])
    @gallery.update(cover_url_file_name: nil, cover_url_file_size: nil, cover_url_content_type: nil, cover_url_updated_at: nil, gallery_photo_id: nil)
    redirect_to galleries_galleryhome_path(id: params[:id])
  end

  def update_multiple
    puts params[:delete]
    puts "*********"
    if params[:status] == 'Active' || params[:status] == 'Inactive'
      @update_status = Gallery.where(id: params[:ids].split(',')).update_all(status: params[:status])
    elsif params[:status] == 'Pre-registered'
      @update_status = CustomGalleryLayout.where(gallery_id: params[:ids].split(',')).update_all(preregistration: true)
    else
      @update_status = CustomGalleryLayout.where(gallery_id: params[:ids].split(',')).update_all(archiving: true)
    end
    @update_gallery_access_pricvacy = CustomGalleryLayout.where(gallery_id: params[:ids].split(',')).update_all(gallery_access_privacy: params[:gallery][:custom_gallery_layouts][:gallery_access_privacy]) if params[:gallery][:custom_gallery_layouts][:gallery_access_privacy].present?
    @update_price_sheet = CustomGalleryLayout.where(gallery_id: params[:ids].split(',')).update_all(pricing_id: params[:gallery][:custom_gallery_layouts][:pricing_id]) if params[:gallery][:custom_gallery_layouts][:pricing_id].present?
    @update_automation_series = CustomGalleryLayout.where(gallery_id: params[:ids].split(',')).update_all(automation_series_id: params[:gallery][:custom_gallery_layouts][:automation_series_id]) if params[:gallery][:custom_gallery_layouts][:automation_series_id].present?
    @update_visitor_info = CustomGalleryLayout.where(gallery_id: params[:ids].split(',')).update_all(visitor_info: params[:gallery][:custom_gallery_layouts][:visitor_info]) if params[:gallery][:custom_gallery_layouts][:visitor_info].present?
    @update_expiration_date = Gallery.where(id: params[:ids].split(',')).update_all(expiration_date: params[:gallery][:expiration_date]) if params[:gallery][:expiration_date].present?
    @update_category_id = CustomGalleryLayout.where(gallery_id: params[:ids].split(',')).update_all(category_id: params[:gallery][:custom_gallery_layouts][:category_id])
    if params[:delete] == "true"
      @delete_gallery = Gallery.where(id: params[:ids].split(',')).update_all(is_delete: true)
    else
      @delete_gallery = Gallery.where(id: params[:ids].split(',')).update_all(is_delete: false)
    end
    redirect_to galleries_path
  end

  def update_cover
    puts "+++++#{params[:g_id]}+++++++"
    @find_gallery = current_brand.galleries.includes(:photos).find(params[:g_id])
  #  @find_cover_photo = @find_gallery.photos.find_by(id: params[:id])
    @update = @find_gallery.update(gallery_photo_id: params[:id],cover_url: nil)
    redirect_to root_path
  end

  def cover
    @gallery_cover = Gallery.find_by(id: params[:id])
  end

  def fileinput
  end

  def add_photos

    @context = context
    @photo = @context.photos.new
    @album = Album.new
    @photos=Gallery.find(params[:gallery_id]).photos.where(is_delete: false).pluck(:image_file_name)
    @watermarks = Watermark.where(brand_id: current_brand.id).order('id ASC')
    @gallery_album = Gallery.find(params[:gallery_id]).albums
    # puts "==============#{@photos.inspect}=============="
  end

  def contact_settings
    @gallery = Gallery.find(params[:id])
    @privilege = @gallery.privilege
    @privilege = Privilege.new unless @privilege.present?
    @labels = @gallery.labels.where(is_delete: false)
    @update_labels = @gallery.labels.update_all(is_delete: false)
  end

  def remove_link_contact
    @gallery=Gallery.find(params[:id])
    @gallery.update_attributes(contact_id:'')
    redirect_to galleries_galleryhome_path(id: params[:id])
    # respond_to do |format|
  end

  def save_photos
    # puts "+++++++++++#{params[:gallery][:photo][:image].inspect}+++++++++++++"
    @photo_array = Array.new
    if params[:gallery].present?
      params[:gallery][:photo][:image].each do |image|
        @photo_array << image.original_filename
        puts "+++#{image.original_filename}+++"
      end
    end

    # puts "#{@photo_array}"

      @gallery = Gallery.find(params[:gallery_id])
    @photos = @gallery.photos.where(is_delete: false).pluck(:image_file_name)
    puts "------#{@photos.inspect}-----"

    @context = context
    puts "context #{@context.inspect}"
    fileExtension = ['jpeg', 'jpg']
    # filename = []
    # params[:gallery][:photo][:image].each do |filenames|
    #   unless filename.include?filenames.original_filename.split('.').first
    #     filename << filenames
    #   end
    # end
    # puts filename
    watermark = Watermark.find(params[:apply_watermark]) unless params[:apply_watermark] == "no_watermark"
    if params[:gallery].present?
      params[:gallery][:photo][:image].each do |p|
        # puts p.original_filename.split('.').last
        if fileExtension.include?p.original_filename.split('.').last
          puts "===#{p.original_filename.split('.').last}=== jpeg"
          # if p.original_filename.include?()
          unless @photos.include?(p.original_filename.tr(" ","_"))
              puts "111#{p.original_filename}111 download (3).jpeg"
            # @photo = @context.photos.build
            unless params[:select_album] == 'no_album'
              album_present = @gallery.albums.find(params[:select_album])
              @photo = album_present.photos.build
            else
              @photo = @context.photos.build
            end
            @photo.image = p
            @photo.save!
            unless params[:apply_watermark] == "no_watermark"
              if watermark.selected_as
                  image1 = create_image_watermark(@photo.image.path, watermark.font_set,\
                  watermark.color, watermark.text_name, watermark.text_opacity_value)
                  @photo.update_attributes(watermark_image: image1)
                  @photo.update_attributes(upload_watrmark: true)
              else
                  image1 = create_watermark_image(watermark.avatar.path, @photo.image.path,\
                  watermark.size, watermark.image_placement)
                  @photo.update_attributes(watermark_image: image1)
                  @photo.update_attributes(upload_watrmark: true)
              end
            end
          end
        end
      end
    end

    redirect_to galleries_galleryhome_path(id: @context.id), notice: "The photo has been successfully created."
  end

  def contactdetails
    @gallery = Gallery.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def client_mail_favorites
    @favorites = Favorite.joins(gallery_visitor: [:gallery]).where('galleries.id = ?',params[:id])
    @photos = Photo.joins(:favorites).where('favorites.id IN (?)',@favorites.map(&:id))
    # redirect_to client_mail_favorites_galleries_path(id: params[:id])
  end

  # def contact_settings
  #   @gallery = Gallery.find(params[:id])
  #   @privilege = @gallery.privilege
  #   if !@privilege.present?
  #     @privilege = Privilege.new()
  #   end
  #   @labels = @gallery.labels.where(is_delete: false)
  #   @update_labels = @gallery.labels.update_all(is_delete: false)
  # end

  def save_privilege
    puts params[:contact_id]
    puts params[:privilege][:gallery_id]
    @gallery = Gallery.find(params[:privilege][:gallery_id])
    @privilege = Privilege.find_by(gallery_id: @gallery.id)
    if @privilege.present?
      @privilege.update(gallery_access_code: params[:privilege][:gallery_access_code],hide_photo_privilege: params[:hide_photo_privilege],label_photo_privilege: params[:label_photo_privilege])
    else
      @privilege = Privilege.new(gallery_id: @gallery.id,gallery_access_code: params[:privilege][:gallery_access_code],hide_photo_privilege: params[:hide_photo_privilege],label_photo_privilege: params[:label_photo_privilege])
      @privilege.save
    end

    #Deleting labels
    @array_of_label_id = @gallery.labels.ids
    @param_array = []
    params[:tags_ids1].split(",").each do |param|
      @param_array << param.to_i
    end
    puts @array_of_label_id - @param_array
    (@array_of_label_id - @param_array).each do |tag|
      @label_to_delete = Label.find(tag)
      @label_to_delete.destroy
    end

    #Adding new labels
    if params[:new_tags].present?
      params[:new_tags].each do |new_tag|
        puts new_tag
        @new_label = Label.create(gallery_id: @gallery.id,name: new_tag)
      end
    end
    #Updating existing labels
    if params[:tags_ids1].present?
      params[:tags_ids1].split(",").zip(params[:tags]).each do |label_id,label_name|
        Label.find(label_id).update(name: label_name)
      end
    end
    redirect_to galleries_galleryhome_path(id: @gallery.id)
  end

  def client_email_labeled
    @gallery = Gallery.find(params[:id])
    @gallery_photos = @gallery.photos.where(is_hidden: true).order(:image_file_name)
    @find_album = @gallery.albums.select(:id)
    @photos = Photo.where("imageable_id IN(?) OR imageable_id IN(?) ", @gallery.id, @find_album).where("is_hidden = ? ",true)
  end



  def change_view_type
    puts params
    current_user.update(view_type: params[:view_type] )
    @galleries = current_brand.galleries.where(is_delete: false).order(sort_column + " " + sort_direction)
  end

  def remove_label
    puts params
    @label = Label.find(params[:label_id])
    respond_to do |format|
      format.js
    end
  end

  def delete_label
    puts params
    @delete_label = Label.find(params[:label_id])
    @delete_label.update(is_delete: true)
    puts @delete_label.as_json
    redirect_to contact_settings_galleries_path(id: params[:id], contact_id: params[:contact_id])
    # respond_to do |format|
    #   format.js
    # end
  end


  def delete_hidden_photos
    params[:hidden_photos].split(',').each do |photo|
      Photo.find(photo).destroy
    end
    redirect_to client_email_labeled_galleries_path(id: params[:id])
  end

  def download_mail_send
    puts "comming................."
    if (params[:id].present?)
      @bundle = SecureRandom.urlsafe_base64(nil, false)
      @download_gallery = DownloadGalleryPhoto.create
      # @download_gallery =  Gallery.find(params[:id]).photo_ids
      @download_gallery.photo_ids =  Gallery.find(params[:id]).photo_ids
      @download_gallery.bundle  = @bundle
      @download_gallery.save
      DownloadMailer.selected_download_email(@current_user, @bundle).deliver_now
    else
      @bundle = SecureRandom.urlsafe_base64(nil, false)
      @download_gallery = DownloadGalleryPhoto.create
      @download_gallery.photo_ids = params[:photo]
      @download_gallery.bundle  = @bundle
      @download_gallery.save
      DownloadMailer.selected_download_email(@current_user, @bundle).deliver_now
    end
  end

  def download_link

  end

  def album_download_link
    # puts "((((((((((#{params.inspect}))))))))))"
    @brand = Brand.find_by(id: params[:brand])
    if @brand
      @gallery = @brand.galleries.find_by(id: params[:gallery])
      if @gallery
        if @gallery.gallery_photo_id?
          @cover = Photo.find_by(id: @gallery.gallery_photo_id).image
          puts "#{((((((((@cover.url))))))))}"
        elsif @gallery.cover_url?
          @cover = @gallery.cover_url
        end
      else
        render :file => 'public/error.html'
      end
    else
      render :file => 'public/error.html'
    end
  end

  def download_page
    @images = DownloadGalleryPhoto.find_by(bundle: params[:bundle]).photo_ids

    require 'zip/zipfilesystem'
    @selected_photos = Photo.where('id IN (?)', @images)
    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @selected_photos.each do |file|
        zos.put_next_entry(file.image_file_name)
        zos.print IO.read(file.image.path)
      end
    end
    send_file t.path, type: 'application/zip', filename: 'Photos.zip'
    t.close
  end

  def load_images
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@#{params.inspect}@@@@@@@@@@@@@@@@@@@@@@@"
    # @find_gallery = current_brand.galleries.includes(:albums).find(params[:id])
    # @gallery_photos1 = @find_gallery.photos
    # @rand_record = @gallery_photos1.all.sample(4)
    @find_gallery = Gallery.find(params[:id])
    @gallery_photos = @find_gallery.photos.where(is_delete: false)
    @album_photos = Photo.where("imageable_id IN(?) AND imageable_type ='Album' AND is_delete = false ", @find_gallery.album_ids)
    gallery = Gallery.new
    @photos_array = gallery.photos
    @photos_array << @gallery_photos
    @photos_array << @album_photos
    puts @photos_array.as_json
    puts "_______________________"
    @rand_record = @photos_array.sample(4)

  end
  def showgallery
  end
  def remove_from_album
    puts "**********"
    puts "#{params.inspect}"
    puts "**********"
    @update_photo = Photo.where('id IN (?)',  params[:photo]).update_all(imageable_type: Gallery, imageable_id: params[:gallery_id])
    respond_to do |format|
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gallery_params
    params.require(:gallery).permit(:name, :shoot_date, :release_date, :expiration_date, :archive, :gallery_layout_id, :contact_id, :status, :cover_url, :gallery_photo_id, :custom_link,:is_delete, photos_attributes: [:image]).merge(brand_id: current_brand.id, user_id: current_user.id)
  end

  def sort_column
    if params[:sort]
      params[:sort]
    else
      params[:sort] = 'galleries.id'
    end
  end

  def sort_column_status
    if params[:sort]
      params[:sort]
    else
      params[:sort] = 'custom_gallery_layouts.id'
    end
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def context
    if params[:gallery_id]
      id = params[:gallery_id]
      @name = current_brand.galleries.find(params[:gallery_id])
    else
      redirect_to galleries_path
    end
  end

  def set_watermark
    @find_gallery = current_brand.galleries.includes(:albums).find(params[:gallery_id])

    # @gallery_photos = GalleryPhoto.where(gallery_id: params[:id]).order(:photo_file_name)

    @gallery_photos = @find_gallery.photos.order(:image_file_name)

    @find_album = @find_gallery.albums.includes(:photos)

    @album_photos = Photo.where(imageable_id: @find_album.pluck(:id))

    # @gallery_photos1 = @find_gallery.photos.limit(4)

    @all_photos1 = @gallery_photos | @album_photos
    @all_photos = @all_photos1.sort { |a, b| a.image_file_name.downcase <=> b.image_file_name.downcase }
    @brand = current_brand
    gallery = @all_photos
    if params[:apply_watermark] == 'no_watermark'
      @brand.update_attributes(apply_watermark: false)
      @gallery_photos.update_all(upload_watrmark: false)
    else
      @brand.update_attributes(apply_watermark: true)
      watermark = Watermark.find(params[:apply_watermark])
      @gallery_photos.update_all(upload_watrmark: false)
      unless watermark.is_default
        Watermark.update_all(is_default: nil)
        watermark.update_attributes(is_default: true)
      end

      if watermark.selected_as
        gallery.each do |photo|
          image1 = create_image_watermark(photo.image.path, watermark.font_set,\
          watermark.color, watermark.text_name, watermark.text_opacity_value)
          photo.update_attributes(watermark_image: image1)
        end
      else
        gallery.each do |photo|
          image1 = create_watermark_image(watermark.avatar.path, photo.image.path,\
          watermark.size, watermark.image_placement)
          photo.update_attributes(watermark_image: image1)
        end
      end
    end
  end
end
