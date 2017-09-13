class MusicPlansController < ApplicationController
  before_action :set_music_plan, only: [:show, :edit, :update, :destroy]
  def index
    @music_plans = MusicPlan.all
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @music_plan.update(music_plan_params)
        format.html { redirect_to music_plans_path, notice: 'Music Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @music_plan.destroy
    respond_to do |format|
      format.html { redirect_to music_plans_url, notice: 'Music Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music_plan
      @music_plan = MusicPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def music_plan_params
      params.require(:music_plan).permit(:name, :no_of_songs, :songs_per_playlist, :data_period, :price, :stripe_id)
    end
end
