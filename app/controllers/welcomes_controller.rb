class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange
  before_action :set_query, :set_gon

  def index
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
      shared = {
        all: I18n.t("all"),
        locale: I18n.locale,
        mostRequest: @query.most_requested_services,
        genderInfo: @query.gender_info,
        accessInfo: @query.access_info,
        accessMainService: @query.access_main_service,
        mostRequestPeriodic: @query.most_request_periodic,
        ticketTrackingByGenders: @query.ticket_tracking_by_genders,
        overallRating: @query.overall_rating,
        feedbackTrend: @query.feedback_trend,
        feedbackSubCategories: @query.feedback_sub_categories
      }

      gon.push(shared)
    end

    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
