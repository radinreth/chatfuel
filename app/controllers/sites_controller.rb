require Rails.root.join('db', 'seed', 'site.rb')

class SitesController < ApplicationController
  before_action :ensure_file_exits, only: [:import]

  def index
    @pagy, @sites = pagy(authorize(Site.all))
  end

  def new
    @site = authorize Site.new
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

  def import
    tempfile = file_params[:file]
    ::Seed::Site.generate!(tempfile.path)
    redirect_to sites_path, status: :moved_permanently, notice: 'Successfully imported'
  end

  def update
    @site = Site.find(params[:id])
    if @site.update(site_params)
      redirect_to @site, status: :moved_permanently, notice: 'site updated successfully!'
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to sites_path
  end

  private

  def ensure_file_exits
    begin
      file_params
    rescue
      redirect_to sites_path, status: :moved_permanently, alert: 'File required!' and return
    end
  end

  def file_params
    params.require(:site).permit(:file)
  end

  def site_params
    params.require(:site).permit(:status, :name, :code)
  end
end
