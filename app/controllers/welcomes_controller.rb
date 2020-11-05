class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange, except: :filter
  before_action :set_query, :set_gon, except: :filter
  before_action :set_active_tab_nav, except: :filter

  def index
    respond_to do |format|
      format.html { render layout: "welcome" }
      format.js do
        @query = DashboardQuery.new(filter_options)
      end
    end
  end

  def filter
    render json: { display_name: @location_filter.display_name, district_list_name: @location_filter.district_list_name }
  end

  def access_info
    render json: @query.access_info, status: :ok
  end

  def service_tracked
    render json: @query.most_tracked_periodic, status: :ok
  end

  private
    def set_active_tab_nav
      @active_tab = params[:q][:active_tab] if params[:q]
    end

    def set_query
      @query = DashboardQuery.new(filter_options)
    end

    def set_gon
      @gon_data = Gonify.new(@query).chart_data
      @gon_data[:all] = I18n.t("all")
      @gon_data[:no_data] = I18n.t("no_data")
      @gon_data[:locale] = I18n.locale

      gon.push(@gon_data)
    end

    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
