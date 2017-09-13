class ClientViewsController < ApplicationController
  before_action :set_client_view, only: [:show, :edit, :update, :destroy]

  # GET /client_views
  # GET /client_views.json
  def index
    # @client_views = ClientView.all
  end

  # GET /client_views/1
  # GET /client_views/1.json
  def show
  end

  # GET /client_views/new
  def new
    @client_view = ClientView.new
  end

  # GET /client_views/1/edit
  def edit
  end

  # POST /client_views
  # POST /client_views.json
  def create
    @client_view = ClientView.new(client_view_params)

    respond_to do |format|
      if @client_view.save
        format.html { redirect_to @client_view, notice: 'Client view was successfully created.' }
        format.json { render :show, status: :created, location: @client_view }
      else
        format.html { render :new }
        format.json { render json: @client_view.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_views/1
  # PATCH/PUT /client_views/1.json
  def update
    respond_to do |format|
      if @client_view.update(client_view_params)
        format.html { redirect_to @client_view, notice: 'Client view was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_view }
      else
        format.html { render :edit }
        format.json { render json: @client_view.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_views/1
  # DELETE /client_views/1.json
  def destroy
    @client_view.destroy
    respond_to do |format|
      format.html { redirect_to client_views_url, notice: 'Client view was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_view
      @client_view = ClientView.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_view_params
      params.fetch(:client_view, {})
    end
end
