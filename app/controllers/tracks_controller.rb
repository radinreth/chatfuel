class TracksController < ApplicationController
  def create
    @track = Track.new track_params
    if @track.save
      head :created
    end
  end

  private

  def track_params
    params.require(:track).permit(:code)
  end
end
