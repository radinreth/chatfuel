class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def new
    @site = Site.new
  end

  def show
    @site = Site.find params[:id]
    @tracks = @site.tracks
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new site_params
    if @site.save
      redirect_to @site, status: :created, notice: 'site created successfully!'
    end
  end

  def update
    @site = Site.find(params[:id])
    if @site.update(site_params)
      redirect_to @site, status: :ok, notice: 'site updated successfully!'
    end
  end

  private

  def site_params
    params.require(:site).permit(:name, :code)
  end
end
