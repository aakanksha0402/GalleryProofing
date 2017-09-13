class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  helper_method :array_checking

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  def albumlist
    @album = Album.new
    @gallery = current_brand.galleries.includes(:albums).find(params[:id])
    @albumlist = @gallery.albums.where("parent = ? ",0)
    @c = @gallery.albums.where(parent: @albumlist.map(&:id))
    @c1 = @gallery.albums.where(parent: @c.map(&:id)).to_a
    @c2 = @gallery.albums.where(parent: @c1.map(&:id)).to_a
    # @gallery_album=Album.where("gallery_id = ? AND parent = ?", params[:id],0).order("created_at")
    unless params[:id].present?
      respond_to do |format|
        format.js
      end
    end
  end

  def albumhome

    @gallery = current_brand.galleries.includes(:albums).find(params[:gallery_id])

    if params[:album_id]
      @level_restrict=@gallery.albums.find(params[:album_id])
      @last_album = @level_restrict.children_album
    end

    @album = @gallery.albums.find(params[:album_id])
    @sub_album = Album.where(parent: @album.id)
    @find_album1 = @gallery.albums
    @album_photos1 = Photo.where("imageable_type = 'Album' AND imageable_id IN(?) AND is_delete = false", @find_album1.ids)
    @album_photos = @album_photos1.where("photos.is_delete = ?", false)
    @album_photos1 = @album.photos.limit(4)
    offset = rand(@album_photos.count)
    # Rails 4
    @rand_record = @album_photos1.all.shuffle[0..3]
    @rand_record.each do |p|
    end
    # vish
   @find_gallery = Gallery.find(params[:gallery_id])
    if @find_gallery.gallery_photo_id.present?
    @find_pic = Photo.find(@find_gallery.gallery_photo_id)
    end
    if @album.album_photo_id.present?
      @find_pic = @album.photos.find(@album.album_photo_id)
    end
    # @album_name = Album.find(params[:album_id]).name
    @share_album_mailer = AlbumShare.new
    @brand_id= Gallery.find(params[:gallery_id]).brand_id
    @brand_name = Brand.find(@brand_id).brand_name
    respond_to do |format|
      format.js
    end
  end

  # GET /albums/new
  def new
    @album = Album.new
    if params[:album_id]
      @level=Album.find_by(id: params[:album_id])
      puts "_________"
      puts @level.level
    end
  end

  # GET /albums/1/edit
  def edit
  end

  def password_generate
    puts params
    if params[:gallery_ids].present?
      params[:gallery_ids].each do |pass|
        @pass=(0...6).map { ('a'..'z').to_a[rand(26)] }.join
        @album_password=Album.find_by(id: pass).update(password: @pass.upcase)
      end
    end
    redirect_to galleries_galleryhome_path(id: params[:id])
  end

  def set_password
    puts params[:id]
    @album_password=Album.find_by(id: params[:albumid]).update(password: params[:album][:password])
    redirect_to galleries_galleryhome_path(id: params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
   puts"#####################-------------------------------------------------------"
    puts "Album ID = "
    puts params.inspect
    puts params[:album_id]
    puts"-------------------------------------------------------"
    @gallery = current_brand.galleries.find(params[:album][:gallery_id])
    @find_album = @gallery.albums
    # @find_album=Album.find_by(gallery_id: params[:album][:gallery_id])

    respond_to do |format|
      if @album.save
        puts "--------------#{params}----------------"
        if params[:album_id]
          @a = @find_album.find(params[:album_id])
          @find_album_photos = @a.photos.update_all(imageable_id: @album.id)
        end
        # @find_album_photos = Photo.where('imageable_type = ? AND imageable_id = ?', 'Album', params[:album_id]).update_all(imageable_id: @album.id)
        # @find_album_photos = AlbumPhoto.where(album_id: params[:album_id]).update_all(album_id: @album.id)
        format.html { redirect_to galleries_galleryhome_path(id: params[:album][:gallery_id]), notice: 'Album was successfully created.' }
        format.json { render galleries_galleryhome_path(id: params[:album][:gallery_id]), status: :created, location: @album }
        format.js {redirect_to albums_albumlist_path(id: params[:id])}
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def test
    respond_to do |format|
      format.js
    end
  end
  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    @album=Album.find_by(id: params[:id])
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to galleries_galleryhome_path(id: @album.gallery_id), notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end


  def update_cover
    # @find_gallery = current_brand.galleries.includes(:photos).find(params[:g_id])
    #
    # @photo=@find_gallery.photos.find_by(id: params[:id])
    #
    # @update=@find_gallery.update(gallery_photo_id: @photo.id)
    #
    # redirect_to root_path

    # @gallery = current_brand.galleries.find()
    puts "go into update cover album"

    puts "***********#{params.inspect}***********"
    @album = Album.find(params[:id])
    if params[:val].present?
      @album.update!(album_photo_id: params[:val])
    elsif params[:album][:cover_url]
      @album.album_photo_id = nil
      @album.update!(album_params)
    else
    end
    redirect_to galleries_galleryhome_path(id: params[:gallery_id])
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    puts params
    @album=Album.find_by(id: params[:id])
    @album.destroy
    respond_to do |format|
      format.html { redirect_to galleries_galleryhome_path(id: @album.gallery_id), notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_cover_pic
    @album = Album.find(params[:id])
    @album.update(cover_url_file_name: nil ,cover_url_file_size: nil ,cover_url_content_type: nil ,cover_url_updated_at: nil, album_photo_id: nil)
    redirect_to galleries_galleryhome_path(id: @album.gallery_id)
  end

  def add_photos
    puts "________________+++++++++++++++++++++++++++))))________________________________"
    @context = context
    @photo = @context.photos.new
    @album=Album.new
    @photos=Album.find(params[:album_id]).photos.where(is_delete: false).pluck(:image_file_name)
    @gallery_album = @gallery.albums

    # @context = context
    # @photo = @context.photos.new
    # @album = Album.new
    # @photos=Gallery.find(params[:gallery_id]).photos.where(is_delete: false).pluck(:image_file_name)
    # @watermarks = Watermark.where(brand_id: current_brand.id).order('id ASC')git
    # @gallery_album = Gallery.find(params[:gallery_id]).albums
  end

  def save_photos
      puts "------#{params.inspect}-----"
    @photo_array = Array.new
    params[:album][:photo][:image].each do |image|
      @photo_array << image.original_filename
      puts "+++#{image.original_filename}+++"
    end
    @album = Album.find(params[:album_id])
    @photos =  @photos = @album.photos.where(is_delete: false).pluck(:image_file_name)



    @context = context
    fileExtension = ['jpeg', 'jpg']
    # filename = []
    # params[:album][:photo][:image].each do |filenames|
    #   unless filename.include?filenames.original_filename.split('.').first
    #     filename << filenames
    #   end
    # end
    # filename.each do |f|
    #   puts f.original_filename
    # end
    params[:album][:photo][:image].each do |p|
      if fileExtension.include?p.original_filename.split('.').last
                # @photo = @context.photos.build
          unless @photos.include?(p.original_filename.tr(" ","_"))
              unless params[:select_album] == 'no_album'
                album_present = @gallery.albums.find(params[:select_album])
                @photo = album_present.photos.build
              else
                @photo = @context.photos.build
              end
          @photo.image = p
          @photo.save!
        end
      end
    end
      redirect_to galleries_galleryhome_path(id: params[:gallery_id])
      # redirect_to albums_albumhome_path(album_id: params[:album_id],gallery_id: params[:gallery_id])


  end

  def load_images
    puts "^^^^^^^^^^^^#{params.inspect}^^^^^^^^^^"
    @find_album = Album.find(params[:album_id])
    @find_album1 = @find_album.photos
    @rand_record = @find_album1.all.limit(4).order("RANDOM()")

  end

  def gallery_load_images
    @find_gallery = Gallery.find(params[:id])
    @gallery_photos = @find_gallery.photos
    @album_photos = Photo.where("imageable_id IN(?) AND imageable_type ='Album'", @find_gallery.album_ids)
    gallery = Gallery.new
    @photos_array = gallery.photos
    @photos_array << @gallery_photos
    @photos_array << @album_photos

    puts @photos_array.as_json
    puts "_______________________"
    @rand_record1 = @photos_array.sample(4)
  end

  def download_mail_send
     @bundle = SecureRandom.urlsafe_base64(nil, false)
     @download_album = DownloadGalleryPhoto.create
     @download_album.photo_ids =  Album.find(params[:id]).photo_ids
     @download_album.bundle  = @bundle
     @download_album.save
      @gallery = Album.find(params[:id]).gallery
      @brand = @gallery.brand
      # @gallery_name = Gallery.find(@gallery_id).name
      # @brand_id = Gallery.find(@gallery_id).brand_id
      # @brand_name = Brand.find(@brand_id).brand_name
  end

  def share_details
    puts "&&&&&&&&&&&&&&&&#{params.inspect}&&&&&&&&&&&&"
    # @album_id = params[:album_share][:album_id]
    @gallery_id = Album.find(params[:album_share][:album_id]).gallery_id
    @current_brand = current_brand.brand_name
    puts "#{@current_brand}"
    if params[:id].present?
      @album_cover_url = Album.find_by(id: params[:id])
    else
      @album_cover_url = Album.find_by(id: params[:album_share][:album_id])
    end

    params[:recipient].split(',').each do |email|
      if email == '' || email == ' '
      else
        if params[:id].present?
          puts "#{params[:id]}-------present"
          @album_share_details = AlbumShare.new(recipient: email, subject: params[:album_share][:subject], headline: params[:album_share][:headline], buttontext: params[:album_share][:buttontext], message: params[:album_share][:message], album_id: params[:id])
        else
          @album_share_details = AlbumShare.new(recipient: email, subject: params[:album_share][:subject], headline: params[:album_share][:headline], buttontext: params[:album_share][:buttontext], message: params[:album_share][:message], album_id: params[:album_share][:album_id])
        end
        @album_share_details.save
        ShareAlbumMailer.album_share_mailer(@album_share_details, @current_brand ).deliver_now
      end
    end
    redirect_to galleries_galleryhome_path(id: @gallery_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:gallery_id, :parent,:title,:level,:cover_url,:album_photo_id,:password)
    end

    def context
      if params[:album_id]
        id = params[:album_id]
        @gallery = current_brand.galleries.find(params[:gallery_id])
        @name = @gallery.albums.find(params[:album_id])
      else
        redirect_to galleries_path
      end
    end


end
