class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def show
    @site = Site.find params[:id]
    @tracks = @site.tracks
  end
end
