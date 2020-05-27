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
      redirect_to @site, status: :moved_permanently, notice: t("created.success")
    else
      render :new, status: :unprocessable_entity, alert: t("created.fail")
    end
  end

  def import
    begin
      tempfile = file_params[:file]
      ::SiteService.import(tempfile.path)
      redirect_to sites_path, status: :moved_permanently, notice: t("imported.success")
    rescue
      redirect_to sites_path, status: :moved_permanently, alert: t("imported.fail")
    end
  end

  def update
    authorize @site
    if @site.update(site_params)
      redirect_to @site, status: :moved_permanently, notice: t("updated.success")
    else
      render :edit, alert: t("updated.fail")
    end
  end

  def destroy
    authorize @site
    @site.destroy
    redirect_to sites_path, status: :moved_permanently, notice: t("deleted.success")
  end

  private
    def set_site
      @site ||= Site.find(params[:id])
    end

    def ensure_file_exits
      begin
        file_params
      rescue
        redirect_to(sites_path, status: :moved_permanently, alert: t("required.file")) && return
      end
    end

    def file_params
      params.require(:site).permit(:file)
    end

    def site_params
      params.require(:site).permit(:name, :code).merge(status: params[:site][:status].to_i)
    end
end
