class EmailTemplatesController < ApplicationController
  layout false, only: [:preview]
  before_filter :authenticate_user!
  before_action :set_email_template, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /email_templates
  # GET /email_templates.json
  def index
    if @current_user_permissions.find_by(permission_name: "View Email Template").value == false
      @not_authorized = true
    end
    if @current_user_permissions.find_by(permission_name: "Add Email Template").value == false
      @not_authorized_to_add = true
    end
      if params[:email_template].present?
        @params_email_templates = current_brand.email_templates.where(default_email_template_id: params[:email_template]).order(sort_column + " " + sort_direction)
      elsif params[:automation_series].present?
        @automation_series = AutomationSeries.includes(:email_templates).find(params[:automation_series])
        @params_email_templates = @automation_series.email_templates
      else
        @params_email_templates = current_brand.email_templates.all.order(sort_column + " " + sort_direction)
      end
      @email_templates = current_brand.email_templates.all.order(sort_column + " " + sort_direction)
      @default_email_templates = DefaultEmailTemplate.all
      @automation_series = current_brand.automation_series.all
      @all = @automation_series | @default_email_templates

      @default_email_template_type = DefaultEmailTemplateType.all

  end

  # GET /email_templates/1
  # GET /email_templates/1.json
  def show
  end

  # GET /email_templates/new
  def new
    if @current_user_permissions.find_by(permission_name: "Add Email Template").value == false
      @not_authorized_to_add = true
    end
    @email_template = EmailTemplate.new
  end

  # GET /email_templates/1/edit
  def edit
  end

  # POST /email_templates
  # POST /email_templates.json
  def create
    @email_template = EmailTemplate.new(email_template_params)

    respond_to do |format|
      if @email_template.save
        format.js
        # format.html { redirect_to email_templates_path, notice: 'Email template was successfully created.' }
        # format.json { render :show, status: :created, location: @email_template }
      else
        format.js
        # format.html { render :new }
        # format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_templates/1
  # PATCH/PUT /email_templates/1.json
  def update
    if @current_user_permissions.find_by(permission_name: "Edit Email Template").value == false
      @not_authorized = true
      render( :edit)
    else
      respond_to do |format|
        if @email_template.update(email_template_params)
          format.html { redirect_to email_templates_path, notice: 'Email template was successfully updated.' }
          format.json { render :index, status: :ok, location: @email_template }
        else
          format.html { render :edit }
          format.json { render json: @email_template.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /email_templates/1
  # DELETE /email_templates/1.json
  def destroy
    @email_template.destroy
    respond_to do |format|
      format.html { redirect_to email_templates_path, notice: 'Email template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_template
    respond_to do |format|
      format.js
    end
  end

  def preview
    respond_to do |format|
      format.html
    end
  end

  def email_activity
    @galleries = current_brand.galleries
    @invoices = current_brand.invoices
    if @galleries
      @shares = GalleryShare.where(gallery_id: @galleries.pluck)
      @shares = @shares.email(params[:email]) if params[:email].present?
      @shares = @shares.gallery_id(params[:gallery][:id]) if params[:gallery][:id].present? if params[:gallery].present?
    end
    puts @shares.as_json
    if @invoices
      @invoice_emails = InvoiceEmail.where(invoice_id: @invoices.pluck)
      @invoice_emails = @invoice_emails.email(params[:email]) if params[:email].present?
    end
    @all_emails = @shares | @invoice_emails

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_template
      @email_template = EmailTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_template_params
      params.require(:email_template).permit(:name, :email_subject, :headline, :button_text, :email_body).merge(brand_id: current_brand.id, default_email_template_id: params[:email_template][:id])
    end

    def sort_column
      if params[:sort]
        params[:sort]
      else
       params[:sort] = "email_templates.id"
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
