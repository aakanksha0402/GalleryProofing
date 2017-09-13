class MusicCategoriesController < ApplicationController
  before_action :set_music_category, only: [:show, :edit, :update, :destroy]

  # GET /music_categories
  # GET /music_categories.json
  def index
    @music_categories = MusicCategory.all
  end

  # GET /music_categories/1
  # GET /music_categories/1.json
  def show
  end

  # GET /music_categories/new
  def new
    @music_category = MusicCategory.new
  end

  # GET /music_categories/1/edit
  def edit
  end

  # POST /music_categories
  # POST /music_categories.json
  def create
    @music_category = MusicCategory.new(music_category_params)

    respond_to do |format|
      if @music_category.save
        format.html { redirect_to @music_category, notice: 'Music category was successfully created.' }
        format.json { render :show, status: :created, location: @music_category }
      else
        format.html { render :new }
        format.json { render json: @music_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /music_categories/1
  # PATCH/PUT /music_categories/1.json
  def update
    respond_to do |format|
      if @music_category.update(music_category_params)
        format.html { redirect_to @music_category, notice: 'Music category was successfully updated.' }
        format.json { render :show, status: :ok, location: @music_category }
      else
        format.html { render :edit }
        format.json { render json: @music_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /music_categories/1
  # DELETE /music_categories/1.json
  def destroy
    @music_category.destroy
    respond_to do |format|
      format.html { redirect_to music_categories_url, notice: 'Music category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music_category
      @music_category = MusicCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def music_category_params
      params.require(:music_category).permit(:name)
    end
end
