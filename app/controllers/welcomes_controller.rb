class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange

  def index
    @query = DashboardQuery.new(filter_options)
    gon.all = I18n.t("all")
    gon.locale = I18n.locale

    respond_to do |format|
      format.html { render layout: "welcome" }
      format.js
    end
  end

  def filter
    render json: { data: @location_filter.display_name }
  end

  private
    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
