class GalleryVisitorsController < ApplicationController
  before_action :set_gallery_visitor, only: [:show, :edit, :update, :destroy]

  # GET /gallery_visitors
  # GET /gallery_visitors.json
  def index
    @gallery_visitors = GalleryVisitor.all
  end

  # GET /gallery_visitors/1
  # GET /gallery_visitors/1.json
  def show
  end

  # GET /gallery_visitors/new
  def new
    @gallery_visitor = GalleryVisitor.new
  end

  # GET /gallery_visitors/1/edit
  def edit
  end

  # POST /gallery_visitors
  # POST /gallery_visitors.json
  def create
    @gallery_visitor = GalleryVisitor.new(gallery_visitor_params)

    respond_to do |format|
      if @gallery_visitor.save
        format.html { redirect_to @gallery_visitor, notice: 'Gallery visitor was successfully created.' }
        format.json { render :show, status: :created, location: @gallery_visitor }
      else
        format.html { render :new }
        format.json { render json: @gallery_visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gallery_visitors/1
  # PATCH/PUT /gallery_visitors/1.json
  def update
    respond_to do |format|
      if @gallery_visitor.update(gallery_visitor_params)
        format.html { redirect_to @gallery_visitor, notice: 'Gallery visitor was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery_visitor }
      else
        format.html { render :edit }
        format.json { render json: @gallery_visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gallery_visitors/1
  # DELETE /gallery_visitors/1.json
  def destroy
    @gallery_visitor.destroy
    respond_to do |format|
      format.html { redirect_to gallery_visitors_url, notice: 'Gallery visitor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_gallery_visitor
    puts params
    params[:gallery_visitor_ids].split(",").each do |id|
      GalleryVisitor.find(id).update(is_delete: true)
    end
    redirect_to reports_gallery_visitors_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery_visitor
      @gallery_visitor = GalleryVisitor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_visitor_params
      params.require(:gallery_visitor).permit(:email, :gallery_id)
    end
end
