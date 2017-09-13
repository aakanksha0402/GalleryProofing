class AutomationSeriesEmailTemplatesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_automation_series_email_template, only: [:show, :edit, :update, :destroy]

  # GET /automation_series_email_templates
  # GET /automation_series_email_templates.json
  def index
    @automation_series_email_templates = AutomationSeriesEmailTemplate.all
  end

  # GET /automation_series_email_templates/1
  # GET /automation_series_email_templates/1.json
  def show
  end

  # GET /automation_series_email_templates/new
  def new
    @automation_series_email_template = AutomationSeriesEmailTemplate.new
  end

  # GET /automation_series_email_templates/1/edit
  def edit
  end

  # POST /automation_series_email_templates
  # POST /automation_series_email_templates.json
  def create
    @automation_series_email_template = AutomationSeriesEmailTemplate.new(automation_series_email_template_params)
    respond_to do |format|
      if @automation_series_email_template.save
        format.html { redirect_to automation_series_index_path, notice: 'Automation series email template was successfully created.' }
        format.json { render :show, status: :created, location: @automation_series_email_template }
      else
        format.html { render :new }
        format.json { render json: @automation_series_email_template.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PATCH/PUT /automation_series_email_templates/1
  # PATCH/PUT /automation_series_email_templates/1.json
  def update
    respond_to do |format|
      if @automation_series_email_template.update(automation_series_email_template_params)
        format.html { redirect_to automation_series_index_path, notice: 'Automation series email template was successfully updated.' }
        format.json { render :show, status: :ok, location: @automation_series_email_template }
      else
        format.html { render :edit }
        format.json { render json: @automation_series_email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /automation_series_email_templates/1
  # DELETE /automation_series_email_templates/1.json
  def destroy
    @automation_series_email_template.destroy
    respond_to do |format|
      format.html { redirect_to automation_series_email_templates_url, notice: 'Automation series email template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_automation_series_email_template
      @automation_series_email_template = AutomationSeriesEmailTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def automation_series_email_template_params
      params.require(:automation_series_email_template).permit(:automation_series_id, :email_template_id, :default_receipient_type_id, :default_trigger_type_id, :trigger_days, :template_name)
    end
end
