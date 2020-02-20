class TracksController < ApplicationController
  def create
    @track = Track.new track_params
    if @track.save
      @site = Site.find_by(code: @track.site_code)
      @track.update(site: @site)
      # TODO: add track to :step
      head :created
    end
  end

  private

  def track_params
    params.require(:track).permit(:code)
  end
end
