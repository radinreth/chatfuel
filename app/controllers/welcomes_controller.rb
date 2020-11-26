class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange

  def index
    @query = DashboardQuery.new(filter_options)
    
    gon.all = I18n.t("all")
    gon.locale = I18n.locale
    gon.mostRequestedServices = @query.most_requested_services
    gon.gender_info = @query.gender_info

    respond_to do |format|
      format.html { render layout: "welcome" }
      format.js
    end
  end

  def filter
    render json: { display_name: @location_filter.display_name, district_list_name: @location_filter.district_list_name }
  end

  private
    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
