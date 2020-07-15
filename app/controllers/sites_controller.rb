class SitesController < ApplicationController
  before_action :ensure_file_exits, only: [:import]
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  def index
    authorize Site
    @pagy, @provinces = pagy_array(SiteService.new(params).provinces)
    @site = Site.new
  end

  def show
    authorize @site
    @tracks = @site.tracks
  end

  def create
    @site = Site.new(site_params)
    authorize @site

    respond_to do |format|
      if @site.save
        flash[:notice] = t("created.success")
        format.js { redirect_to @site, status: :moved_permanently, notice: t("created.success") }
      else
        flash[:alert] = @site.errors.full_messages
        format.js
        format.html { redirect_to sites_path, alert: t("created.fail") }
      end
    end

    redirect_to sites_path
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
      flash[:notice] = t("updated.success")
    else
      flash[:alert] = @site.errors.full_messages
    end

    redirect_to sites_path
  end

  def destroy
    authorize @site
    @site.destroy
    redirect_to sites_path, status: :moved_permanently, notice: t("deleted.success")
  end

  def download
    csv = Rails.root.join("db", "seed", "assets", "site.csv")
    send_file csv, filename: "sample.csv", disposition: "attachment", type: "text/csv"
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
      params.require(:site).permit(:name, :code, :lat, :lng).merge(status: params[:site][:status].to_i)
    end
end
