class SongLibrariesController < ApplicationController
  before_action :set_song_library, only: [:show, :edit, :update, :destroy]

  # GET /song_libraries
  # GET /song_libraries.json
  def index
    @musics = MusicLibrary.all
    @playlists = current_user.playlists.all
    @musics = @musics.singer(params[:singer]) if params[:singer].present?
    @musics = @musics.title(params[:title]) if params[:title].present?
    @new_playlist = Playlist.new
  end

  # GET /song_libraries/1
  # GET /song_libraries/1.json
  def show
  end

  # GET /song_libraries/new
  def new

  end

  # GET /song_libraries/1/edit
  def edit
  end

  # POST /song_libraries
  # POST /song_libraries.json
  def create

  end

  # PATCH/PUT /song_libraries/1
  # PATCH/PUT /song_libraries/1.json
  def update

  end

  # DELETE /song_libraries/1
  # DELETE /song_libraries/1.json
  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.

end
