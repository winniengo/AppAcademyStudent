class TracksController < ApplicationController
 def index
    @tracks = Track.all
  end

  def create
    @track = Track.create(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def new
    @track = Track.new
  end

  def show
    @track = Track.find(params[:id])
  end

  def destroy
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  private

  def track_params
    params.require(:track).permit(:name)
  end
end