class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange, only: :index
  before_action :set_query, :set_gon, only: :index

  def access_info
    render json: @query.access_info, status: :ok
  end
  def index
    @active_tab = params[:q][:active_tab] if params[:q]

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
      @gon_data = {
        all: I18n.t("all"),
        locale: I18n.locale,
        mostRequest: @query.most_requested_services,
        genderInfo: @query.gender_info,
        accessInfo: @query.access_info,
        accessMainService: @query.access_main_service,
        mostTrackedPeriodic: @query.most_tracked_periodic,
        ticketTrackingByGenders: @query.ticket_tracking_by_genders,
        overallRating: @query.overall_rating,
        feedbackTrend: @query.feedback_trend,
        feedbackSubCategories: @query.feedback_sub_categories
      }

      gon.push(@gon_data)
    end

    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
