class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange, except: :filter
  before_action :setup_data_on_search, except: :filter
  
  def index
    respond_to do |format|
      format.html { render layout: "welcome" }
      format.json { render json: @gon_data }
      format.js
    end
  end

  def filter
    render json: { display_name: @location_filter.display_name, described_name: @location_filter.described_name }
  end

  def access_info
    render json: @query.access_info, status: :ok
  end

  def service_tracked
    render json: @query.most_tracked_periodic, status: :ok
  end

  def feedback_trend
    render json: @query.feedback_trend, status: :ok
  end

  private
    def set_active_tab_nav
      @active_tab = params[:q][:active_tab] if params[:q]
    end

    def set_query
      options = params[:options].presence || filter_options
      @query = DashboardQuery.new(options)
    end

    def set_gon
      @gon_data = Gonify.new(@query).send(params["fetch"].to_sym) rescue {}
      @gon_data.merge!(t_gon, query_options)
      gon.push(@gon_data)
    end

    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end

    def query_options
      { query_options: @query.options }
    end

    def t_gon
      {
        all: I18n.t("all"),
        no_data: I18n.t("no_data"),
        locale: I18n.locale,
        most_tracked_label: I18n.t("welcomes.most_service_tracked_by_periodic"),
        most_requested_label: I18n.t("welcomes.most_requested_services")
      }
    end

    def setup_data_on_search
      return unless request.xhr?
  
      
      set_query
      set_gon
      set_active_tab_nav
    end
end
