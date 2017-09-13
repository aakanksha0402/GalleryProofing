class PlaylistsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_playlist, only: [:show, :edit, :update, :destroy, :user_music]

  # GET /playlists
  # GET /playlists.json
  def index
    @user = current_user
    @playlists = @user.playlists.all
    @new_playlist = Playlist.new
    if @playlists.present?
      @user_musics = @playlists.first.user_musics.includes(:music_library)
    end
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    @playlist_songs = current_user.user_musics.all.where(playlist_id: @playlist.id)
    @music = Music.where(id: @playlist_songs.map(&:music_id)).to_a
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)
    respond_to do |format|
      if @playlist.save
        format.js
        format.html { redirect_to playlists_path, notice: 'Playlist was successfully created.' }
        format.json { render :index, status: :created, location: @playlist }
      else
        format.js
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to playlists_path, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_song_to_playlist
    @user_music = UserMusic.new
    @user_music.playlist_id = params[:playlist]
    @user_music.music_library_id = params[:music]
    @user_music.user_id = current_user.id
    if @user_music.save
      redirect_to song_libraries_path
    else
      redirect_to song_libraries_path, error: "The Playlist already contains this song."
    end
  end

  def remove_song_from_playlist
    @user_music = current_user.user_musics.find_by(music_library_id: params[:id])
    @user_music.destroy!
    redirect_to playlists_path
  end

  def user_music
    @user_musics = @playlist.user_musics.includes(:music_library)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:name).merge(user_id: current_user.id)
    end
end
