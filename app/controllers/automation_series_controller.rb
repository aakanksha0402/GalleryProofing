class AutomationSeriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_automation_series, only: [:show, :edit, :update, :destroy]

  # GET /automation_series
  # GET /automation_series.json
  def index
    if @current_user_permissions.find_by(permission_name: "View Email Template").value == false
      @not_authorized = true
    end
    if @current_user_permissions.find_by(permission_name: "Add Email Template").value == false
      @not_authorized_to_add = true
    end
    @automation_series = current_brand.automation_series.all.order("name ASC")
    @as = AutomationSeries.new
    @email_templates = current_brand.email_templates.all
  end

  # GET /automation_series/1
  # GET /automation_series/1.json
  def show
  end

  # GET /automation_series/new
  def new
    @automation_series = AutomationSeries.new
  end

  # GET /automation_series/1/edit
  def edit
  end

  # POST /automation_series
  # POST /automation_series.json
  def create
    @automation_series = AutomationSeries.new(automation_series_params)

    respond_to do |format|
      if @automation_series.save
        format.js
        format.html { redirect_to automation_series_index_path, notice: 'Automation series was successfully created.' }
        format.json { render :show, status: :created, location: @automation_series }
      else
        format.js        
        format.html { render :new }
        format.json { render json: @automation_series.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /automation_series/1
  # PATCH/PUT /automation_series/1.json
  def update
    @automation_series = current_brand.automation_series.find_by(id: params[:id])

    respond_to do |format|
      if @automation_series.update(automation_series_params)
        format.html { redirect_to automation_series_index_path, notice: 'Automation series was successfully updated.' }
        format.json { render :show, status: :ok, location: @automation_series }
      else
        format.html { render :edit }
        format.json { render json: @automation_series.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /automation_series/1
  # DELETE /automation_series/1.json
  def destroy
    @automation_series.destroy
    respond_to do |format|
      format.html { redirect_to automation_series_index_url, notice: 'Automation series was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_template_from_series
    @aset = AutomationSeriesEmailTemplate.find_by(id: params[:id])
    @aset.destroy
    respond_to do |format|
      format.html { redirect_to automation_series_index_url, notice: 'Email Template was successfully removed' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_automation_series
      @automation_series = AutomationSeries.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def automation_series_params
      params.require(:automation_series).permit(:name).merge(brand_id: current_brand.id)
    end
end
