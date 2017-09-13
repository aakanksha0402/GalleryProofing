class ViewsController < HomePagesController
    before_action :requirements, only: [:contact, :home, :pricing, :album, :gallery, :gallery_password,:access_code,:gallery_slider,:image_load,:hide_unhide, :album_password, :download_digital, :required_pin, :social_sharing, :facebook_sharing]
    # before_action :home_page_color_logo_effect, only: [:view_home_page, :category, :view_widget, :galleries_password, :get_both, :get_password]
    before_action :gallery_color_logo_effect, only: [:gallery, :home, :album, :pricingm, :contact, :gallery_password, :album_password, :required_pin, :social_sharing, :facebook_sharing]
    before_filter :set_cache_headers

    def view_home_page
        @home_page = StudioHomePage.find_by(brand_id: params[:brand])
        # @home_page = StudioHomePage.find_by(subdomain: request.subdomain)
        if @home_page.nil?
            render file: 'public/error.html'
        else
            @brand = @home_page.brand
            if @home_page.sort_on == 'Gallery Shoot Date, Oldest First'
                # @galleries = Gallery.where(brand_id: params[:brand]).order(shoot_date: :desc)
                @galleries = @brand.galleries.includes(:custom_gallery_layout).order(shoot_date: :desc)
            elsif @home_page.sort_on == 'Gallery Shoot Date, Newest First'
                # @galleries = Gallery.where(brand_id: params[:brand]).order(:shoot_date)
                @galleries = @brand.galleries.includes(:custom_gallery_layout).order(:shoot_date)
            elsif @home_page.sort_on == 'A-Z'
                # @galleries = Gallery.where(brand_id: params[:brand]).order(:name)
                @galleries = @brand.galleries.includes(:custom_gallery_layout).order(:name)
            elsif @home_page.sort_on == 'Z-A'
                # @galleries = Gallery.where(brand_id: params[:brand]).order(name: :desc)
                @galleries = @brand.galleries.includes(:custom_gallery_layout).order(name: :desc)
            end
            @custom_layout = @galleries.map(&:custom_gallery_layout)
            # @categories = Category.where(brand_id: params[:brand])
            @categories = @brand.categories
            @no_category = CustomGalleryLayout.where(gallery_id: @galleries.map(&:id)).where(category_id: nil)

            @no_category_gallery = @brand.galleries.where(id: @no_category.map(&:gallery_id)).to_a
            @color_set = @brand.color_logos.find(@home_page.color_logo_id)

            if @color_set.theme == 'Light'
                session[:theme] = '#ffffff'
                session[:div] = '#FAFAFA'
                session[:icon] = '#DEDEDE'
                session[:text] = '#ffffff'
            else
                session[:theme] = '#333333'
                session[:div] = '#353535'
                session[:icon] = '#5D5D5D'
                session[:text] = '#333333'
            end
            session[:font_set] = @color_set.font_set
            session[:primary_color] = @color_set.primary_color
            session[:secondary_color] = @color_set.secondary_color
            @gallery = CustomGalleryLayout.new
        end
    end

    def home
        @gallery_albums = @gallery.albums.where('parent = ?', 0)
        @hide_photos = @custom_gallery_layout.hide_photos.present?
        @total = if @hide_photos
                     0
                 else
                     @gallery.photos.count
                 end
        @gallery.albums.each do |a|
            @total += a.photos.count
        end
    end

    def gallery
        if @gallery.cover_url.present?
            @pic = @gallery.cover_url.url
        elsif @gallery.gallery_photo_id.present?
            @photo = @gallery.photos_with_albums.find(@gallery.gallery_photo_id)
            @pic = @photo.image.url
        end
    end

    def album
      #puts "=========#{params[:gallery]}======"
        @pin_pass = false
        @gallery_visitor = GalleryVisitor.where('gallery_id = ? AND email = ?', params[:gallery], session["email_visitor_#{params[:gallery]}"]).first
        unless @gallery_visitor.nil?
            @favorites = Favorite.where(gallery_visitor_id: @gallery_visitor.id)
            @favorite_photos = Photo.where(id: @favorites.pluck(:photo_id)).pluck(:id)
            @cart = Cart.where(gallery_visitor_id: @gallery_visitor.id, is_active: true).first
            @lineitems = @cart.line_items if @cart
        end
        if params[:album] == 'all'
            @all_photos = @gallery.photos
        else
            @current_album = Album.where('gallery_id = ? AND id = ?', @gallery.id, params[:album]).first
            # @current_album = @gallery.albums.find(params[:album])
            if @current_album.nil?
                render file: 'public/error.html'
            else
                @album_count = Album.where('gallery_id = ? AND parent = ?', @gallery.id, @current_album.id)
                # @album_count = @gallery.albums.where("parent = ?", @current_album.id)
                if @album_count.nil?
                    render file: 'public/error.html'
                else
                    @count = @album_count.count
                    @album = @gallery.albums.where(parent: params[:album])
                    if @album.count.zero?
                        @a = @gallery.albums.find(params[:album])
                        @all_album_photos = @a.photos
                    end
                end
            end
        end

        if @custom_gallery_layout.pricing_id.present?
            @pricing = @custom_gallery_layout.pricing

            @cat = @pricing.catalogs.where(checked: true)

            @groups = Group.where('id IN(?)', @cat.pluck(:group_id)).order(:id)

            @catalogs = @cat.select(:print_size_one, :print_size_two, :group_id, :fix_group_id, :resolution).group(:print_size_one, :print_size_two, :group_id, :fix_group_id, :resolution).order(:print_size_one, :print_size_two)

            @digital = @cat.where('fix_group_id = ?', 2)

            # @all_catalogs = @pricing.catalogs.where(checked: true)
            # @var = @all_catalogs.uniq.select(:group_id)
            # @groups = @pricing.groups.where(id: @var)
            # @group_wise_catalogs = @all_catalogs.where("group_id IN(?)", @groups.ids)
            # @catalogs = @group_wise_catalogs.select(:print_size_one, :print_size_two, :group_id).group(:print_size_one, :print_size_two, :group_id)
        end
    end

    # def custom_link
    #   @c = params[:custom_link]
    #     @gallery = Gallery.find_by(custom_link: @c)
    #     @brand = Brand.find(@gallery.brand_id)
    #     @home_page = StudioHomePage.find_by(brand_id: @brand.id)
    #     @color_set = ColorLogo.find(@home_page.color_logo_id)
    #     redirect_to view_gallery_path(gallery: @gallery.id, custom_link: @gallery.custom_link)
    # end

    def gallery_slider
      #puts "%%%%%%%%%%%%%%%#{params[:gallery].inspect}%%%%%%:%%%%%#{params[:photo].inspect}%%%%%%%%%%"

      @photo= Photo.find_by(id:params[:photo])
      @labelall=Label.all
      @all_photos = @gallery.photos_with_albums

      if params[:black_white] == "true"
        if session.key?(params[:photo])
            puts "inside session destroy"
            session.delete(params[:photo])
            puts session.key?(params[:photo])
        else
            puts "inside else"
            session[params[:photo]] = "b&w"
            puts session.key?(params[:photo])
        end
      end
      respond_to do |format|
          format.html
          format.js
      end
    end
    def category
        @d = params[:category]

        # @home_page = StudioHomePage.find_by_subdomain!(request.subdomain)
        @home_page = StudioHomePage.find(params[:brand])
        @brand = Brand.find(@home_page.brand_id)
        @find_galleries = CustomGalleryLayout.where(category_id: @d)
        @galleries = Gallery.where(id: @find_galleries.pluck(:gallery_id))
        @custom_layout = CustomGalleryLayout.where(category_id: nil)
        @gallery = Gallery.where(id: @custom_layout.pluck(:gallery_id))
        @category = Category.find(params[:category])
    end

    def view_widget
        @c = params[:gallery]
        if @c.nil?
            @invalid_password = true
        else
            @gallery = Gallery.find(params[:gallery])
            @find_gallery_layout = @gallery.custom_gallery_layout
            if @find_gallery_layout.password.present?
                if params[:password].present?
                    @find_gallery_layout_password = CustomGalleryLayout.find_by(gallery_id: @find_gallery_layout.gallery_id, password: params[:password])
                    if @find_gallery_layout_password.nil?
                        @invalid_password = true
                    else
                        @find_gallery = Gallery.find_by(id: @find_gallery_layout_password.gallery_id)
                        @test_pass = true
                    end
                else
                    @password_required = true
                end
            else
                @test_pass = true
            end
        end
    end

    def galleries_password
        if params[:password].present?
            @gallery_layout = CustomGalleryLayout.find_by(password: params[:password])
            if @gallery_layout.nil?
                @invalid_password = true
            else
                @gallery = Gallery.find_by(id: @gallery_layout.gallery_id)
                if params[:email].present?
                    @gallery_visitor = GalleryVisitor.where('gallery_id = ? AND email = ?', @gallery.id, params[:email])
                    if @gallery_visitor.nil?
                        @gallery_visitor = GalleryVisitor.create!(gallery_id: @gallery.id, email: params[:email])
                    end
                    session["email_visitor_#{@gallery.id}"] = @gallery_visitor.email
                    @cart = cart(@gallery_visitor.id)
                    @test_pass = true
                else
                    @test_pass = true
                end
            end
        else
            @password_required = true
        end
    end

    def galleries_password_visitors
        if params[:gallery].present?
            @gallery_layout = CustomGalleryLayout.find_by(gallery_id: params[:gallery])
            if @gallery_layout.password.present?
                if params[:password].present?
                    @gallery_layout = CustomGalleryLayout.find_by(gallery_id: params[:gallery], password: params[:password])
                    if @gallery_layout.nil?
                        @invalid_password = true
                    else
                        @gallery = Gallery.find_by(id: @gallery_layout.gallery_id)
                        if @gallery.nil?
                            @invalid_password = true
                        else
                            if params[:email].present?
                                @gallery_visitor = GalleryVisitor.where('gallery_id = ? AND email = ?', @gallery.id, params[:email])
                                if @gallery_visitor.nil?
                                    @gallery_visitor = GalleryVisitor.create!(gallery_id: @gallery.id, email: params[:email])
                                end
                                session["email_visitor_#{@gallery.id}"] = @gallery_visitor.email
                                @cart = cart(@gallery_visitor.id)
                            end
                            @test_pass = true
                        end
                    end
                else
                    @password_required = true
                end
            else
                @gallery = Gallery.find_by(id: @gallery_layout.gallery_id)
                @test_pass = true
            end
        else
            @choose_gallery = true
        end
    end

    def get_both
        custom_layout = CustomGalleryLayout.find_by(gallery_id: params[:gallery_id])
        unless custom_layout.nil?
            @show_password = if custom_layout.password.present?
                                 true
                             else
                                 false
                            end
            @show_email = if custom_layout.email_require == true
                              true
                          else
                              false
                          end
       end
    end

    def get_password
        custom_layout = CustomGalleryLayout.find_by(gallery_id: params[:gallery_id])
        if custom_layout.nil?
            @show_password = false
        else
            if custom_layout.password.present?
                @show_password = true
                puts @show_password
            else
                @show_password = false
                puts @show_password
             end
        end
    end

    def pricing
        if @custom_gallery_layout.pricing_id.present?
            @pricing = @custom_gallery_layout.pricing

            @catalogs = @pricing.catalogs.where(checked: true)

            @var = @catalogs.uniq.pluck(:group_id)
            @groups = @pricing.groups.where(id: @var)

            @c_test = Catalog.where(group_id: @groups.pluck(:id))

            @catalogs = @c_test.where('pricing_id = ? AND checked = ?', 1, true).select(:print_size_one, :print_size_two, :group_id, :depth, :price).group(:print_size_one, :print_size_two, :group_id, :depth, :price)

        else
            redirect_to view_home_path(gallery: params[:gallery])
        end
    end

    def contact
    end

    def gallery_password
        if @gallery.custom_gallery_layout.email_require == true
            if @gallery.contact.email == params[:email]
                @email_status = 'true'
              if @gallery.privilege.gallery_access_code.present?
                          @code = 'true'
                        else
                          @code = 'false'
                        end
            end
            @gallery_visitor = GalleryVisitor.where('gallery_id = ? AND email = ?', @gallery.id, params[:email]).first
            if @gallery_visitor.nil?
                @gallery_visitor = GalleryVisitor.create!(gallery_id: @gallery.id, email: params[:email])
            end
            session["email_visitor_#{@gallery.id}"] = @gallery_visitor.email
            @cart = cart(@gallery_visitor.id)
            @email_status = 'true'
        else
            @email_status = 'true'
        end
        if @gallery.custom_gallery_layout.gallery_access_privacy == 'public_password'
            puts 'if 1'
            puts @gallery.custom_gallery_layout.password

            if @gallery.custom_gallery_layout.password == params[:password]
                @pass_status = 'true'
            else
                @pass_status = 'false'
            end
        else
            @pass_status = 'true'
        end
    end
    def access_code
      if @gallery.privilege.gallery_access_code.present?
        if @gallery.privilege.gallery_access_code==params[:access_code]
          @code_access="true"
            @gallery_visitor=session["email_visitor_#{@gallery.id}"]
            @gallery_visitor=GalleryVisitor.find_by(email:@gallery_visitor)
            @gallery_visitor.update_attribute(:is_admin, "true")
            session["is_admin"]="true"
        else
          @code_access="false"
        end
        puts @code_access
      end
    end
    def required_pin
        @gallery = Gallery.find(params[:gallery])
        if params[:photo_id] == 'all'
            ClientviewMailer.clientview_email(params[:gallery], session["email_visitor_#{@gallery.id}"]).deliver_now
        end
        if params[:pin].present?
            @pin_pass = if @custom_gallery_layout.PIN == params[:pin]
                            true
                        else
                            false
                        end
        else
            @pin_pass == true
        end
    end

    def without_pin
        @gallery = Gallery.find(params[:gallery])
        ClientviewMailer.clientview_email(params[:gallery], session["email_visitor_#{@gallery.id}"]).deliver_now
    end

    def social_sharing
        if @gallery.cover_url.present?
            @pic = @gallery.cover_url.url
        elsif @gallery.gallery_photo_id.present?
            @photo = @gallery.photos.find(@gallery.gallery_photo_id)
            @pic = @photo.image.url
        end
        @content = if @custom_gallery_layout.content.present?
                       @custom_gallery_layout.content
                   else
                       'Check out the photos from ' + @gallery.name + '.'
                   end
    end

    def facebook_sharing
        if @gallery.cover_url.present?
            @pic = @gallery.cover_url.url
        elsif @gallery.gallery_photo_id.present?
            @photo = @gallery.photos.find(@gallery.gallery_photo_id)
            @pic = @photo.image.url
        end
    end

    def download_all_photo
        @gallery = Gallery.find(params[:gallery])
        respond_to do |format|
            format.html
            format.js
        end
    end

    def verify_mail
    end

    def check_email
        require 'zip/zipfilesystem'
       @gallery_visitor = GalleryVisitor.find(params[:gallery_visitor_id])
        respond_to do |format|
          if @gallery_visitor.email == params[:email]
            @files = @gallery_visitor.gallery.photos
            @album_id = @gallery_visitor.gallery.albums
            @files1 = Photo.where("imageable_type = ? AND imageable_id IN(?)", 'Album', @album_id.pluck(:id))

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
            @file_size = t.size

            format.html
          else
            format.html { redirect_to verify_mail_path(gallery_visitor_id: params[:gallery_visitor_id] ), notice: 'Invalid Email address' }
          end
        end
      end
      def download_zip
        require 'zip/zipfilesystem'
        @gallery_visitor = GalleryVisitor.find(params[:gallery_visitor_id])
        @files = @gallery_visitor.gallery.photos
        @album_id = @gallery_visitor.gallery.albums
        @files1 = Photo.where('imageable_type = ? AND imageable_id IN(?)', 'Album', @album_id.pluck(:id))

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

        send_file t.path, :type => "application/zip", :filename => "1-of-1.zip"
        t.close
      end

    def album_password
        @album = @gallery.albums.find(params[:album])
        if @album.nil?
            render file: 'public/error.html'
        else
            if @album.password == params[:password]
                session["album_#{params[:album]}"] = true
                @pass = true
            else
                @pass = false
            end
            respond_to :js
        end
    end

    def show_modal
        @lineitem_qwantity = 1
        if params[:digital_catalog_id].present?
            @gallery = Gallery.find(params[:gallery])
            @catalogs = Catalog.find(params[:digital_catalog_id])
            @group = Group.find(params[:group_id])
            @from_digital = params[:from_digital]
            @item_found = search_item(params[:photo], @catalogs.id)
            @price = 0.00
            if params[:from] == '1'
                @price = @catalogs.price
            else
                @catalogs.digital_media_prices.each do |cat|
                    @price = if params[:from] == '2'
                                 cat.indiviual_photo_price
                             else
                                 cat.all_gallery_photo_price
                             end
                end
            end
            if params[:is_photo] == 'true' && params[:from] != '3'
                @price *= @gallery.photos.count
            end
        elsif params[:catalog_id].present?
            @gallery = Gallery.find(params[:gallery])
            @catalogs = Catalog.where('id = ?', params[:catalog_id])
            @item_found = search_item(params[:photo], @catalogs.first.id)
            @group = Group.find(params[:group_id])
            @price = if params[:is_photo] == 'true'
                         @catalogs.first.price * @gallery.photos.count
                     else
                         @catalogs.first.price
                     end
        else
            @gallery = Gallery.find(params[:gallery])
            @group = Group.find(params[:group_id])
            print_size_one = params[:print_size_one]
            print_size_two = params[:print_size_two]
            group_id = params[:group_id]
            @catalogs = Catalog.where(checked: true, print_size_one: print_size_one, print_size_two: print_size_two, group_id: group_id)
            @item_found = search_item(params[:photo], @catalogs.first.id)
            @price = 0.00
            @price = if params[:is_photo] == 'true'
                         @catalogs.first.price * @gallery.photos.count
                     else
                         @catalogs.first.price
                     end
        end
    end

    def download_digital
        @photo = Photo.find(params[:photo])
        # send_file "#{Rails.root}/public/#{params[:photo]}", type: 'image/jpeg', disposition: 'attachment'
        send_file @photo.image.path,
                  filename: @photo.image_file_name,
                  type: @photo.image_content_type,
                  disposition: 'attachment'

        puts '-----------Downloded----------'
    end

    def save_download_session
        session[:download] = params[:photo]
    end

    def image_load
        @label=LabelPhoto.where(photo_id:params[:id])
        if @label.present?
          @label_class="true"
        else
          @label_class="false"
        end
        @favourite=Favorite.find_by(photo_id:params[:id])
        if @favourite.present?
          @fav_class="true"
        else
          @fav_class="false"
        end
        puts "*********#{@fav_class}*********"
        @photo_load=@gallery.photos_with_albums.find_by(id:params[:id])
        @image_name=@photo_load.image_file_name
        respond_to do |format|
          format.js
        end
    end

    def hide_unhide
        @label=LabelPhoto.where(photo_id:params[:id])
        @photo_load=@gallery.photos_with_albums.find_by(id:params[:id])
        @photo_load.update(is_hidden: !@photo_load.is_hidden)
    end

    # set label method

    def setlabels
      if params[:label].present?
      @label=params[:label]
     @label.each do |label|
             @photos=LabelPhoto.create(photo_id:params[:photo],label_id:label)
     end
   end
      @labels = LabelPhoto.where(photo_id:params[:photo])
      respond_to :js
    end
    private

    def requirements
        # @domain_brand = request.subdomain
        @domain_brand = params[:brand]

        # @home_page = StudioHomePage.find_by(subdomain: @domain_brand)
        @home_page = StudioHomePage.find_by(brand_id: @domain_brand)

        if @home_page.nil?
            render file: 'public/error.html'
        else

            @color_set = ColorLogo.find(@home_page.color_logo_id)

            @brand = @home_page.brand

            @gallery = Gallery.where('id =? AND brand_id = ?', params[:gallery], @brand.id).first
            if @gallery.present?
                @custom_gallery_layout = @gallery.custom_gallery_layout
                @color_logo = ColorLogo.find(@custom_gallery_layout.color_logo_id)
            else
                render file: 'public/error.html'
            end
            # if @color_set.theme == "Light"
            #   session[:theme] = "#ffffff"
            #   session[:div] = "#FAFAFA"
            #   session[:icon] = "#DEDEDE"
            #   session[:text] = "#ffffff"
            # else
            #   session[:theme] = "#333333"
            #   session[:div] = "#353535"
            #   session[:icon] = "#5D5D5D"
            #   session[:text] = "#333333"
            # end
            # session[:font_set] = @color_set.font_set
            # session[:primary_color] = @color_set.primary_color
            # session[:secondary_color] = @color_set.secondary_color
        end
    end

    def set_cache_headers
        response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
        response.headers['Pragma'] = 'no-cache'
        response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
    end

    def home_page_color_logo_effect
        if @color_set.theme == 'Light'
            session[:theme] = '#ffffff'
            session[:div] = '#FAFAFA'
            session[:icon] = '#DEDEDE'
            session[:text] = '#ffffff'
        else
            session[:theme] = '#333333'
            session[:div] = '#353535'
            session[:icon] = '#5D5D5D'
            session[:text] = '#333333'
        end
        session[:font_set] = @color_set.font_set
        session[:primary_color] = @color_set.primary_color
        session[:secondary_color] = @color_set.secondary_color
    end

    def gallery_color_logo_effect
        if @color_logo.theme == 'Light'
            session[:gallery_theme] = '#ffffff'
            session[:gallery_div] = '#FAFAFA'
            session[:gallery_icon] = '#DEDEDE'
            session[:gallery_text] = '#ffffff'
        else
            session[:gallery_theme] = '#333333'
            session[:gallery_div] = '#353535'
            session[:gallery_icon] = '#5D5D5D'
            session[:gallery_text] = '#333333'
        end
        session[:gallery_font_set] = @color_logo.font_set
        session[:gallery_primary_color] = @color_logo.primary_color
        session[:gallery_secondary_color] = @color_logo.secondary_color
    end

    def search_item(id, catalog_id)
        @photo_ids = false
        if session["email_visitor_#{params[:gallery]}"].present?
            @lineitem_qwantity = 1
            @gallery_visitor = GalleryVisitor.where('gallery_id = ? AND email = ?', params[:gallery], session["email_visitor_#{params[:gallery]}"]).first
            if @gallery_visitor
                @cart = cart(@gallery_visitor.id)
                @line_items = @cart.line_items
                if @line_items.present?
                    @line_items.each do |line_item|
                        next unless id.to_i == line_item.photo_id && catalog_id.to_i == line_item.catalog_id
                        @photo_ids = true
                        @lineitem_id = line_item.id
                        @lineitem_qwantity = line_item.quantity
                    end
                end
            end
        end
        @photo_ids
    end
end
