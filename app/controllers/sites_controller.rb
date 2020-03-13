require Rails.root.join("db", "seed", "site.rb")

class SitesController < ApplicationController
  before_action :ensure_file_exits, only: [:import]
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @sites = pagy(Site.order(tracks_count: :desc))
    authorize @sites
    respond_to do |format|
      format.html
      format.json { render json: @sites }
    end
  end

  def new
    @site = Site.new(status: 1)
    authorize @site
  end

  def show
    authorize @site
    @tracks = @site.tracks
  end

  def edit
    authorize @site
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to @site, status: :moved_permanently, notice: "site created successfully!"
    else
      render :new, status: :unprocessable_entity, alert: "save fail"
    end
  end

  def import
    tempfile = file_params[:file]
    ::Seed::Site.generate!(tempfile.path)
    redirect_to sites_path, status: :moved_permanently, notice: "Successfully imported"
  end

  def update
    authorize @site
    if @site.update(site_params)
      redirect_to @site, status: :moved_permanently, notice: "site updated successfully!"
    end
  end

  def destroy
    authorize @site
    @site.destroy
    redirect_to sites_path, status: :moved_permanently, notice: "destroy successfully"
  end

  private
    def set_site
      @site ||= Site.find(params[:id])
    end

    def ensure_file_exits
      begin
        file_params
      rescue
        redirect_to(sites_path, status: :moved_permanently, alert: "File required!") && return
      end
    end

    def file_params
      params.require(:site).permit(:file)
    end

    def site_params
      params.require(:site).permit(:name, :code).merge(status: params[:site][:status].to_i)
    end
end
