class AlbumPhotosController < ApplicationController
  config.relative_url_root = ""
  before_action :set_album_photo, only: [:show, :edit, :update, :destroy]

  # GET /album_photos
  # GET /album_photos.json
  def index
    @album_photos = AlbumPhoto.all
  end

  # GET /album_photos/1
  # GET /album_photos/1.json
  def show
    @album_photo = AlbumPhoto.find_by(id: 3)
  end

  # GET /album_photos/new
  def new
    @album1=Album.where(gallery_id: params[:gallery_id])
    @gallery=Gallery.find_by(id: params[:gallery_id])
    @album_photo = AlbumPhoto.new
    @album=Album.new
    @level=Album.find_by(id: params[:album_id])
  end

  # GET /album_photos/1/edit
  def edit
  end

  def travel
    puts "HELLOOOOOOOOO"
    redirect_to new_album_photo_path(gallery_id: params[:gallery_id],album_id: params[:album_id])
  end

  # POST /album_photos
  # POST /album_photos.json
  def create
    puts "PARAMETERS:::::"
    puts params.inspect

    @album_photo = AlbumPhoto.new(album_photo_params)
    puts "%%%%%%%%%"
    puts @album_photo.as_json
    puts params[:album_id]
    puts params[:album_photo][:image]
    @gallery_photos = GalleryPhoto.where(gallery_id: params[:id])
    # puts "$$$$$$$$$$"
    # puts @gallery_photos.as_json
    # puts "$$$$$$$$$$"
    @album=Album.where(gallery_id: params[:id])
    @album_photos = AlbumPhoto.where(album_id: @album.map(&:id)).to_a
    # puts "$$$$$$$$$$"
    # puts @album_photos.as_json
    # puts "$$$$$$$$$$"
    @all_photos =@gallery_photos+@album_photos
    # puts "$$$$$$$$$$"
    # puts @all_photos.as_json
    # puts "$$$$$$$$$$"
    @count = 0
    params[:album_photo][:image].each do |img|
      @a = 1
      @b = 1

      puts img.original_filename
      @album_photos.each do |album_photo|
        if album_photo.image_file_name == img.original_filename
          @a = 0
          @count = @count + 1
          break
        end
      end
      @gallery_photos.each do |gallery_photo|
        if gallery_photo.photo_file_name == img.original_filename
          @b = 0
          @count = @count + 1
          break
        end
      end
      if @a != 0 && @b!= 0
          AlbumPhoto.create(image: img,album_id: params[:album_photo][:album_id])
        else
          puts @a
          puts @b
          # redirect_to new_album_photo_path(gallery_id: params[:gallery_id],album_id: params[:album_id])
      end
    end
    puts @count
    redirect_to galleries_galleryhome_path(id: params[:id])
    # respond_to do |format|
    #   if @album_photo.save
    #     format.html { redirect_to galleries_galleryhome_path(id: params[:id]), notice: 'Album photo was successfully created.' }
    #     format.json { render :show, status: :created, location: @album_photo }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @album_photo.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /album_photos/1
  # PATCH/PUT /album_photos/1.json
  def update
    respond_to do |format|
      if @album_photo.update(album_photo_params)
        format.html { redirect_to @album_photo, notice: 'Album photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @album_photo }
      else
        format.html { render :edit }
        format.json { render json: @album_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /album_photos/1
  # DELETE /album_photos/1.json
  def destroy
    @album_photo.destroy
    respond_to do |format|
      format.html { redirect_to album_photos_url, notice: 'Album photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album_photo
      @album_photo = AlbumPhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_photo_params
      params.require(:album_photo).permit(:album_id,:image)
    end
end
