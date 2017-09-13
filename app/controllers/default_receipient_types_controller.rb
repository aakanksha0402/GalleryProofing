class DefaultReceipientTypesController < ApplicationController
  before_action :set_default_receipient_type, only: [:show, :edit, :update, :destroy]

  # GET /default_receipient_types
  # GET /default_receipient_types.json
  def index
    @default_receipient_types = DefaultReceipientType.all
  end

  # GET /default_receipient_types/1
  # GET /default_receipient_types/1.json
  def show
  end

  # GET /default_receipient_types/new
  def new
    @default_receipient_type = DefaultReceipientType.new
  end

  # GET /default_receipient_types/1/edit
  def edit
  end

  # POST /default_receipient_types
  # POST /default_receipient_types.json
  def create
    @default_receipient_type = DefaultReceipientType.new(default_receipient_type_params)

    respond_to do |format|
      if @default_receipient_type.save
        format.html { redirect_to @default_receipient_type, notice: 'Default receipient type was successfully created.' }
        format.json { render :show, status: :created, location: @default_receipient_type }
      else
        format.html { render :new }
        format.json { render json: @default_receipient_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /default_receipient_types/1
  # PATCH/PUT /default_receipient_types/1.json
  def update
    respond_to do |format|
      if @default_receipient_type.update(default_receipient_type_params)
        format.html { redirect_to @default_receipient_type, notice: 'Default receipient type was successfully updated.' }
        format.json { render :show, status: :ok, location: @default_receipient_type }
      else
        format.html { render :edit }
        format.json { render json: @default_receipient_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /default_receipient_types/1
  # DELETE /default_receipient_types/1.json
  def destroy
    @default_receipient_type.destroy
    respond_to do |format|
      format.html { redirect_to default_receipient_types_url, notice: 'Default receipient type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_receipient_type
      @default_receipient_type = DefaultReceipientType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_receipient_type_params
      params.require(:default_receipient_type).permit(:name, :active, :default_email_template_type)
    end
end
