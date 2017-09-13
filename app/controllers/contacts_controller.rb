class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :duplicate]
  helper_method :sort_column, :sort_direction

  @not_authorized == false
  # GET /contacts
  # GET /contacts.json
  def index
     if @current_user_permissions.find_by(permission_name: "View Contact").value == false
       @not_authorized = true
     end
     if @current_user_permissions.find_by(permission_name: "Add Contact").value == false
       @not_authorized_to_add = true
     end

      if params[:brand].present?
        @contacts = Contact.order(sort_column + " " + sort_direction)
      else
        @contacts = Contact.where(brand_id: current_brand.id).order(sort_column + " " + sort_direction)
      end
      @contacts = @contacts.name_email(params[:search]) if params[:search].present?
      @contacts = @contacts.gallery(params[:gallery]) if params[:gallery].present?
      @contacts = @contacts.tag(params[:tags]) if params[:tags].present?
      @contacts = @contacts.brand(params[:brand]) if params[:brand].present?
      @total_contacts =  Contact.where(brand_id: current_brand.id).order(sort_column + " " + sort_direction)

      respond_to do |format|
        format.html
        format.csv { send_data @contacts.to_csv, filename: "contacts-#{Date.today}.csv" }
      end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show

  end

  # GET /contacts/new
  def new
    if @current_user_permissions.find_by(permission_name: "Add Contact").value == false
      @not_authorized = true
    end
    @contact = Contact.new
    @count = current_user.brands.all.count
    @contact.referred_contacts.build
  end

  # GET /contacts/1/edit
  def edit
    @galleries_of_contacts = current_brand.galleries.where(contact_id: params[:id])
    #Reffered by which contact
    @referred_by = ReferredContact.find_by(reference_contact_id: params[:id])
    # find which contact referred and display

    if @referred_by != nil
      @contact_that_referred = Contact.find_by(id: @referred_by.contact_id)
    end

    #Referred which contacts
    @referred = ReferredContact.where(contact_id: params[:id])
    @c = Contact.where(id: @referred.map(&:reference_contact_id)).to_a
    @gallery = Gallery.new
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    puts params[:contact][:country_id]
    respond_to do |format|
      if @contact.save
        format.html { redirect_to edit_contact_path(@contact), notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def duplicate
  	@dup_contact = @contact.dup
    respond_to do |format|
      if @dup_contact.save
        format.html { redirect_to contacts_path, notice: 'Duplicate Contact was successfully added.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    if @current_user_permissions.find_by(permission_name: "Edit Contact").value == false
      @not_authorized = true
      render( :edit)
    else
      respond_to do |format|
        if @contact.update(contact_params)
          if params[:contact][:referred_contact][:reference_contact_id] != ''
            @refer_contact = ReferredContact.new
            @refer_contact.contact_id = params[:contact][:referred_contact][:contact_id]
            @refer_contact.reference_contact_id = params[:contact][:referred_contact][:reference_contact_id]
            if @refer_contact.save
              format.html { redirect_to edit_contact_path, notice: 'Contact Referred was successfully added.' }
              format.json { render :show, status: :ok, location: @contact }
            end
          else
            format.html { redirect_to contacts_path, notice: 'Contact was successfully updated.' }
            format.json { render :show, status: :ok, location: @contact }
          end
        else
          format.html { redirect_to edit_contact_path, notice: "Resubmit the form" }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find_by(id: params[:id])
    @link_gallery_destroy = Gallery.where(contact_id: @contact.id)
    @link_gallery_destroy.each do |e|
      @update_gallery=Gallery.where(id: e.id).update_all(contact_id: nil)
    end
    respond_to do |format|
      if @contact.destroy
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
      else
        format.html { redirect_to edit_contact_path, notice: 'Cannot be deleted.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:firstname, :lastname, :email, :address1,:address2, :city, :country_id, :pincode, :phone_number, :vendor, :buisinessname, :notes, :brand_id, :contact_id, :reference_contact_id, :tag_list, referred_contacts_attributes: [])
    end

    def sort_column
      if params[:sort]
        params[:sort]
      else
       params[:sort] = "contacts.id"
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
