class DefaultTriggerTypesController < ApplicationController
  before_action :set_default_trigger_type, only: [:show, :edit, :update, :destroy]

  # GET /default_trigger_types
  # GET /default_trigger_types.json
  def index
    @default_trigger_types = DefaultTriggerType.all
  end

  # GET /default_trigger_types/1
  # GET /default_trigger_types/1.json
  def show
  end

  # GET /default_trigger_types/new
  def new
    @default_trigger_type = DefaultTriggerType.new
  end

  # GET /default_trigger_types/1/edit
  def edit
  end

  # POST /default_trigger_types
  # POST /default_trigger_types.json
  def create
    @default_trigger_type = DefaultTriggerType.new(default_trigger_type_params)

    respond_to do |format|
      if @default_trigger_type.save
        format.html { redirect_to @default_trigger_type, notice: 'Default trigger type was successfully created.' }
        format.json { render :show, status: :created, location: @default_trigger_type }
      else
        format.html { render :new }
        format.json { render json: @default_trigger_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /default_trigger_types/1
  # PATCH/PUT /default_trigger_types/1.json
  def update
    respond_to do |format|
      if @default_trigger_type.update(default_trigger_type_params)
        format.html { redirect_to @default_trigger_type, notice: 'Default trigger type was successfully updated.' }
        format.json { render :show, status: :ok, location: @default_trigger_type }
      else
        format.html { render :edit }
        format.json { render json: @default_trigger_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /default_trigger_types/1
  # DELETE /default_trigger_types/1.json
  def destroy
    @default_trigger_type.destroy
    respond_to do |format|
      format.html { redirect_to default_trigger_types_url, notice: 'Default trigger type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_trigger_type
      @default_trigger_type = DefaultTriggerType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_trigger_type_params
      params.require(:default_trigger_type).permit(:name, :active, :default_email_template_type)
    end
end
