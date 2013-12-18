class Admin::SongsController < Admin::Cms::BaseController

  before_action :build_song,  :only => [:new, :create]
  before_action :load_song,   :only => [:show, :edit, :update, :destroy]

  def index
    @songs = Song.page(params[:page])
  end

  def show
    render
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @song.save!
    flash[:success] = 'Song created'
    redirect_to :action => :show, :id => @song
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Song'
    render :action => :new
  end

  def update
    @song.update_attributes!(song_params)
    flash[:success] = 'Song updated'
    redirect_to :action => :show, :id => @song
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Song'
    render :action => :edit
  end

  def destroy
    @song.destroy
    flash[:success] = 'Song deleted'
    redirect_to :action => :index
  end

protected

  def build_song
    @song = Song.new(song_params)
  end

  def load_song
    @song = Song.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Song not found'
    redirect_to :action => :index
  end

  def song_params
    params.fetch(:song, {}).permit(:title, :artist, :year)
  end
end