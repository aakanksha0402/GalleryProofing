class FavoritesController < HomePagesController
  before_action :set_fav, only: [:add_favorite, :remove_favorite]

  def all_favorites
    @brand = Brand.where(id: params[:brand]).first
    if @brand.present?
      @gallery = Gallery.where(brand_id: @brand.id, id: params[:gallery]).first
      if @gallery.present?
        @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", params[:gallery], session["email_visitor_#{params[:gallery]}"]).first
        unless @gallery_visitor.nil?
          @favorites = Favorite.where(gallery_visitor_id: @gallery_visitor.id)
          @favorite_photos = Photo.where(id: @favorites.pluck(:photo_id))
        end
      else
         redirect_to view_path
      end
    else
      render :file => 'public/error.html'
    end
  end

  def add_favorite
    @fav=Favorite.find_by(gallery_visitor_id: @gallery_visitor.id,photo_id:params[:photo_id])
    puts @fav.inspect
    puts "Hello here"
    if @fav.nil?
      @favorites = Favorite.create!(gallery_visitor_id: @gallery_visitor.id, photo_id: params[:photo_id])
    else
      @favourite=@fav.destroy
    end
  end

  def remove_favorite
    @favorites = Favorite.where(gallery_visitor_id: @gallery_visitor.id, photo_id: params[:photo_id]).destroy_all
  end

  def verify_email
    if params[:email] == params[:confirm_email]
      @pass = true
      @gallery = Gallery.find(params[:gallery])
      @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", @gallery.id, params[:email]).first
      if @gallery_visitor.nil?
        @gallery_visitor =  GalleryVisitor.create!(gallery_id: @gallery.id, email: params[:email])
      end
      session["email_visitor_#{@gallery.id}"] = @gallery_visitor.email
      @cart = cart(@gallery_visitor.id)
      puts "call session method from favorites."
    else
      @pass = false
    end
  end

  def share_fav
    @gallery_visitor = GalleryVisitor.find(params[:gallery_visitor_id])

    token = Favorite.getTokenForShare
    @share_favorites = ShareFavorite.new(share_fav_params)
    @share_favorites.token = token
    @share_favorites.save!
    puts GalleryVisitor.exists?(email: @share_favorites.to_email,gallery_id: @gallery_visitor.gallery_id)
    if GalleryVisitor.exists?(email: @share_favorites.to_email,gallery_id: @gallery_visitor.gallery_id)
      share_gallery_visitor = GalleryVisitor.where(email: @share_favorites.to_email,gallery_id: @gallery_visitor.gallery_id).first
      favorite_image_present = Favorite.where(gallery_visitor_id: share_gallery_visitor.id).pluck(:photo_id)
      favorite = Favorite.where(gallery_visitor_id: params[:gallery_visitor_id])
      puts share_gallery_visitor.id
      favorite.each do |fav|
        if !favorite_image_present.include?(fav.photo_id)
          newfav = Favorite.new(gallery_visitor_id: share_gallery_visitor.id,photo_id:fav.photo_id)
          newfav.save!
        end
      end
    else
      share_gallery_visitor = GalleryVisitor.new()
      share_gallery_visitor.email = @share_favorites.to_email
      share_gallery_visitor.gallery_id = @gallery_visitor.gallery_id
      share_gallery_visitor.save!
      favorite = Favorite.where(gallery_visitor_id: params[:gallery_visitor_id])
      favorite.each do |fav|
        newfav = Favorite.new(gallery_visitor_id: share_gallery_visitor.id,photo_id:fav.photo_id)
        newfav.save!
      end
    end
    ShareFavoriteMailer.share_favorites(params[:name],@share_favorites.to_email, @share_favorites.token, @gallery_visitor.email, @gallery_visitor.gallery_id, params[:message],params[:brand_id],share_gallery_visitor.id).deliver_now
  end
  def verify_favorites_mail
    @brand = Brand.find(params[:brand_id])
  end
  def check_favorites_mail
   @gallery_visitor = GalleryVisitor.find(params[:gallery_visitor_id])
    respond_to do |format|
      if @gallery_visitor.email == params[:email]
        format.html {redirect_to view_gallery_url(brand: params[:brand_id],gallery: @gallery_visitor.gallery_id)}
      else
        format.html { redirect_to verify_favorites_mail_path(gallery_visitor_id: params[:gallery_visitor_id],brand_id: params[:brand_id] ), notice: 'Invalid Email address' }
      end
    end
  end
  private
  def share_fav_params
    params.permit(:to_email, :name, :message, :gallery_visitor_id)
  end

  def set_fav
    puts "=========#{params[:gallery]}=====#{session[:email_visitor_1].present?}======"
    #puts session.inspect
    @gallery = Gallery.find(params[:gallery])
    @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", @gallery.id, session["email_visitor_#{@gallery.id}"]).first
  end
end
