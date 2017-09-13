class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /songs
  # GET /songs.json
  def index
    @pl = Playlist.new
    @songs = Song.all
    @music_categories = MusicCategory.all
    @category = @music_categories.first
    @music_plan = MusicPlan.where(music_category_id: @category.id).first
    @musics = Music.all
    if params[:plan].present?
      if params[:plan] == '1'
        @musics = Music.all
      else
        @category = MusicCategory.find(params[:plan])
        @music_plan = MusicPlan.where(music_category_id: @category.id).first
        @musics = Music.where(music_category_id: @category.id)
      end
    else
     @musics = Music.all
    end
    @musics = @musics.theme(params[:theme]) if params[:theme].present?
    @musics = @musics.style(params[:style]) if params[:style].present?
    @musics = @musics.mood(params[:mood]) if params[:mood].present?
    @musics = @musics.song_type(params[:song_type]) if params[:song_type].present?
    @musics = @musics.tempo(params[:tempo]) if params[:tempo].present?
    @musics = @musics.instrument(params[:instrument]) if params[:instrument].present?
    @musics = @musics.artist(params[:artist]) if params[:artist].present?
    @musics = @musics.title(params[:title]) if params[:title].present?
    @music_prices = MusicPlan.where(music_category_id: @category.id).order(:id)

    @trail_subscription = current_user.subscription
    if @trail_subscription
      @trail = @trail_subscription.music_subscription_id.present?
    end

    @current_plan = current_user.plan_billing
    @cmp = @current_plan.music_plan_id
    if @cmp.present?
      @mp = MusicPlan.find(@current_plan.music_plan_id)
      @current_category = @music_categories.find(@mp.music_category_id)
    end

    @playlists = current_user.playlists.all

    @no_of_songs = current_user.user_musics.all.count

    @current_user_subscription = current_user.subscription
    if @current_user_subscription.present?
      @subscription = @current_user_subscription.music_subscription_id.present?
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_prices
    @category = MusicCategory.find(params[:music])
    @music_prices = MusicPlan.where(music_category_id: @category.id).order(:id)
    @music_plan = @music_prices.first
    respond_to do |format|
      format.js
    end
  end

  def subscribe
    @plan_and_billing = current_user.plan_billing
    @music_plan = MusicPlan.find(params[:music_plan][:price])
    @subscription = Subscription.find_by(user_id: current_user.id)
    if current_user.customer_id.present?
      if @subscription.present?
        if @subscription.music_subscription_id.present?
          customer = Stripe::Customer.retrieve(current_user.customer_id)
          puts customer
          subscription = Stripe::Subscription.retrieve(@subscription.music_subscription_id)
          subscription.plan = @music_plan.stripe_id
          subscription.save
          puts subscription
          @subscription.update(music_subscription_id: subscription.id)
        else
          customer = Stripe::Customer.retrieve(current_user.customer_id)
          puts customer
          customer.subscriptions.create(plan: @music_plan.stripe_id)
          customer.save
          @subscription.update(music_subscription_id: customer.subscriptions.data[0].id)
        end
        @all_playlists = current_user.playlists.all
        @all_playlists.each do |playlist|
          @user_music_in_playlists = current_user.user_musics.where(playlist_id: playlist.id)
          @destroy_all_playlists = @user_music_in_playlists.destroy_all
        end
        @plan_and_billing.update(music_plan_id: @music_plan.id)
        redirect_to songs_path
      else
        redirect_to plans_billings_creditcard_path(music_plan_id: @music_plan.id)
      end
    else
      redirect_to plans_billings_creditcard_path(music_plan_id: @music_plan.id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.fetch(:song, {})
    end
end
