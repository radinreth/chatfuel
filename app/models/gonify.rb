class Gonify
  def initialize(query)
    @query = query
  end

  def chart_data
    access_info_chart.merge citizen_feedback_chart
  end

  private

  def access_info_chart
    {
      mostRequest: @query.most_requested_services,
      genderInfo: @query.gender_info,
      accessInfo: @query.access_info,
      accessMainService: @query.access_main_service,
      mostTrackedPeriodic: @query.most_tracked_periodic,
      ticketTrackingByGenders: @query.ticket_tracking_by_genders,
    }
  end

  def citizen_feedback_chart
    {
      overallRating: @query.overall_rating,
      feedbackTrend: @query.feedback_trend,
      feedbackSubCategories: @query.feedback_sub_categories
    }
  end
end
