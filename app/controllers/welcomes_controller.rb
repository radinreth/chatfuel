class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange, only: :index
  before_action :set_query, :set_gon, only: :index

  def index
    @active_tab = params[:q][:active_tab] if params[:q]

    respond_to do |format|
      format.html { render layout: "welcome" }
      format.js
    end
  end

  def filter
    render json: { display_name: @location_filter.display_name, district_list_name: @location_filter.district_list_name }
  end

  private
    def set_query
      @query = DashboardQuery.new(filter_options)
    end

    def set_gon
      @gon_data = Gonify.new(@query).chart_data
      @gon_data[:all] = I18n.t("all")
      @gon_data[:locale] = I18n.locale

      gon.push(@gon_data)
    end

    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
