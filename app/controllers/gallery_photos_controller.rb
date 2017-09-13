class GalleryPhotosController < ApplicationController
  before_action :set_gallery_photo, only: [:show, :edit, :update, :destroy]

  # GET /gallery_photos
  # GET /gallery_photos.json
  def index
    @gallery_photos = GalleryPhoto.all
    @find_gallery=current_brand.galleries.find_by(id: params[:current_gallery_id])
  end

  # GET /gallery_photos/1
  # GET /gallery_photos/1.json
  def show
    render json: @gallery_photo
  end

  # GET /gallery_photos/new
  def new
    @gallery=Gallery.find_by(id: params[:gallery_id])
    @gallery_photo = GalleryPhoto.new
    @find_gallery=current_brand.galleries.find_by(id: params[:current_gallery_id])
    @album=Album.new

  end

  # GET /gallery_photos/1/edit
  def edit
  end

  # POST /gallery_photos
  # POST /gallery_photos.json
  def create

    @gallery_photo = GalleryPhoto.new(gallery_photo_params)
    puts "############"
    puts params
    puts "############"
    puts params[:gallery_photo][:gallery_id]
    puts params[:filename]
    @gallery_photo.gallery_id = params[:gallery_photo][:gallery_id]
    puts "Gallery Photo:"
    puts params
    puts params[:gallery_photo][:photo]
    @gallery_photos = GalleryPhoto.where(gallery_id: params[:id])
    puts "$$$$$$$$$$"
    puts @gallery_photos.count
    puts "$$$$$$$$$$"
    @album=Album.where(gallery_id: params[:id])
    @album_photos = AlbumPhoto.where(album_id: @album.map(&:id)).to_a
    puts "$$$$$$$$$$"
    puts @album_photos.count
    puts "$$$$$$$$$$"
    @all_photos =@gallery_photos+@album_photos
    # puts "$$$$$$$$$$"
    # puts @all_photos.as_json
    # puts "$$$$$$$$$$"
    @count = 0
    params[:gallery_photo][:photo].each do |photo|
      @a = 1
      @b = 1

      puts photo.original_filename
      @album_photos.each do |album_photo|
        if album_photo.image_file_name == photo.original_filename
          @a=0
          @count = @count+1
          break
        end
      end
      @gallery_photos.each do |gallery_photo|
        if gallery_photo.photo_file_name == photo.original_filename
          @b=0
          @count = @count+1
          break
        end
      end
      if @a != 0 && @b!= 0
        GalleryPhoto.create(photo: photo,gallery_id: params[:gallery_photo][:gallery_id])
      else
        puts @a
        puts @b
      end
    end
    puts @count
    redirect_to new_gallery_photo_path(gallery_id: @gallery_photo.gallery_id)
    #
    # respond_to do |format|
    #   if @gallery_photo.save
    #     format.html { redirect_to galleries_galleryhome_path(id: @gallery_photo.gallery_id), notice: 'Gallery photo was successfully created.' }
    #     format.json { render :show, status: :created, location: @gallery_photo }
    #   else
    #     format.html { redirect_to new_gallery_photo_path(gallery_id: params[:gallery_id]) }
    #     format.json { render json: @gallery_photo.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /gallery_photos/1
  # PATCH/PUT /gallery_photos/1.json
  def update
    respond_to do |format|
      if @gallery_photo.update(gallery_photo_params)
        format.html { redirect_to @gallery_photo, notice: 'Gallery photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery_photo }
      else
        format.html { render :edit }
        format.json { render json: @gallery_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gallery_photos/1
  # DELETE /gallery_photos/1.json
  def destroy
    @gallery_photo.destroy
    respond_to do |format|
      format.html { redirect_to gallery_photos_url, notice: 'Gallery photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery_photo
      @gallery_photo = GalleryPhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_photo_params
      params.require(:gallery_photo).permit(:gallery_id,:photo)
    end
end
