class DefaultEmailTemplatesController < ApplicationController
  before_action :set_default_email_template, only: [:show, :edit, :update, :destroy]

  # GET /default_email_templates
  # GET /default_email_templates.json
  def index
    @default_email_templates = DefaultEmailTemplate.all
  end

  # GET /default_email_templates/1
  # GET /default_email_templates/1.json
  def show
    render json: @default_email_template

  end

  # GET /default_email_templates/new
  def new
    @default_email_template = DefaultEmailTemplate.new
  end

  # GET /default_email_templates/1/edit
  def edit
  end

  # POST /default_email_templates
  # POST /default_email_templates.json
  def create
    @default_email_template = DefaultEmailTemplate.new(default_email_template_params)

    respond_to do |format|
      if @default_email_template.save
        format.html { redirect_to @default_email_template, notice: 'Default email template was successfully created.' }
        format.json { render :show, status: :created, location: @default_email_template }
      else
        format.html { render :new }
        format.json { render json: @default_email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /default_email_templates/1
  # PATCH/PUT /default_email_templates/1.json
  def update
    respond_to do |format|
      if @default_email_template.update(default_email_template_params)
        format.html { redirect_to @default_email_template, notice: 'Default email template was successfully updated.' }
        format.json { render :show, status: :ok, location: @default_email_template }
      else
        format.html { render :edit }
        format.json { render json: @default_email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /default_email_templates/1
  # DELETE /default_email_templates/1.json
  def destroy
    @default_email_template.destroy
    respond_to do |format|
      format.html { redirect_to default_email_templates_url, notice: 'Default email template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_json
    email_template = DefaultEmailTemplate.find(params[:id])
    render :text => invoice.to_json
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_email_template
      @default_email_template = DefaultEmailTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_email_template_params
      params.require(:default_email_template).permit(:email_type, :email_subject, :headline, :button_text, :email_body, :text_for_button, :text_after_select, :default_email_template_type)
    end
end
