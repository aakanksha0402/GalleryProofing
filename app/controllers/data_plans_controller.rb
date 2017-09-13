class DataPlansController < ApplicationController
  before_action :set_data_plan, only: [:show, :edit, :update, :destroy]

  # GET /data_plans
  # GET /data_plans.json
  def index
    @data_plans = DataPlan.where(data_period: "Monthly").order(:id)
    @dp = DataPlan.where(data_period: "Yearly").order(:id)
  end

  # GET /data_plans/1
  # GET /data_plans/1.json
  def show
  end

  # GET /data_plans/new
  def new
    @data_plan = DataPlan.new
  end

  # GET /data_plans/1/edit
  def edit
  end

  # POST /data_plans
  # POST /data_plans.json
  def create
    @data_plan = DataPlan.new(data_plan_params)

    respond_to do |format|
      if @data_plan.save
        format.html { redirect_to @data_plan, notice: 'Data plan was successfully created.' }
        format.json { render :show, status: :created, location: @data_plan }
      else
        format.html { render :new }
        format.json { render json: @data_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_plans/1
  # PATCH/PUT /data_plans/1.json
  def update
    respond_to do |format|
      if @data_plan.update(data_plan_params)
        format.html { redirect_to @data_plan, notice: 'Data plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @data_plan }
      else
        format.html { render :edit }
        format.json { render json: @data_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_plans/1
  # DELETE /data_plans/1.json
  def destroy
    @data_plan.destroy
    respond_to do |format|
      format.html { redirect_to data_plans_url, notice: 'Data plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_plan
      @data_plan = DataPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_plan_params
      params.require(:data_plan).permit(:photos_number, :mobile_apps_number, :invoices_number, :data_period, :plan_price)
    end
end
