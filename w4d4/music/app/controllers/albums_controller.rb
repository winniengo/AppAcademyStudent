class AlbumsController < ApplicationController
def index
    @albums = Album.all
  end

  def create
    @album = album.create(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    @album = Album.new
  end

  def show
    @album = Album.find(params[:id])
  end

  def destroy
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private

  def album_params
    params.require(:album).permit(:album_name, :status, :band_id)
  end
end