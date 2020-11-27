class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange
  before_action :set_query, :set_gon

  def access_info
    render json: @query.access_info, status: :ok
  end
  def index
    respond_to do |format|
      format.html { render layout: "welcome" }
      format.js
    end
  end

  def filter
    render json: { data: @location_filter.display_name }
  end

  private
    def set_query
      @query = DashboardQuery.new(filter_options)
    end

    def set_gon
      shared = {
        all: I18n.t("all"),
        locale: I18n.locale,
        mostRequest: @query.most_requested_services,
        genderInfo: @query.gender_info,
        accessInfo: @query.access_info,
        accessMainService: @query.access_main_service,
        mostRequestPeriodic: @query.most_request_periodic,
        ticketTrackingByGenders: @query.ticket_tracking_by_genders
      }

      gon.push(shared)
    end

    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
