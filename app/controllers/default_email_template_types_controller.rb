class DefaultEmailTemplateTypesController < ApplicationController
  before_action :set_default_email_template_type, only: [:show, :edit, :update, :destroy]

  # GET /default_email_template_types
  # GET /default_email_template_types.json
  def index
    @default_email_template_types = DefaultEmailTemplateType.all
  end

  # GET /default_email_template_types/1
  # GET /default_email_template_types/1.json
  def show
  end

  # GET /default_email_template_types/new
  def new
    @default_email_template_type = DefaultEmailTemplateType.new
  end

  # GET /default_email_template_types/1/edit
  def edit
  end

  # POST /default_email_template_types
  # POST /default_email_template_types.json
  def create
    @default_email_template_type = DefaultEmailTemplateType.new(default_email_template_type_params)

    respond_to do |format|
      if @default_email_template_type.save
        format.html { redirect_to @default_email_template_type, notice: 'Default email template type was successfully created.' }
        format.json { render :show, status: :created, location: @default_email_template_type }
      else
        format.html { render :new }
        format.json { render json: @default_email_template_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /default_email_template_types/1
  # PATCH/PUT /default_email_template_types/1.json
  def update
    respond_to do |format|
      if @default_email_template_type.update(default_email_template_type_params)
        format.html { redirect_to @default_email_template_type, notice: 'Default email template type was successfully updated.' }
        format.json { render :show, status: :ok, location: @default_email_template_type }
      else
        format.html { render :edit }
        format.json { render json: @default_email_template_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /default_email_template_types/1
  # DELETE /default_email_template_types/1.json
  def destroy
    @default_email_template_type.destroy
    respond_to do |format|
      format.html { redirect_to default_email_template_types_url, notice: 'Default email template type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_email_template_type
      @default_email_template_type = DefaultEmailTemplateType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_email_template_type_params
      params.require(:default_email_template_type).permit(:name)
    end
end
