module DictionariesHelper
  def total_users_visit_each_functions
    result = StepValue\
      .joins(step: :message, variable_value: :variable)\
      .where(variables: { is_user_visit: true })\
      .where(messages: { platform_name: @platform_name, location_name: @location })
      .where("DATE(step_values.created_at) BETWEEN ? AND ?", @start_date, @end_date)\
      .order(:raw_value)\
      .group(:raw_value)\
      .count

    return {} if result.blank?

    default_chartjs_color_mapping.merge(result)
  end

  # prevent inconsistent chartjs color
  def default_chartjs_color_mapping
    return {} unless @user_visit_variable.present?

    default = {}
    @user_visit_variable.values.each { |val| default[val.raw_value] = 0 }
    default
  end

  def total_users_feedback
    StepValue
      .joins(step: :message, variable_value: :variable)\
      .where(messages: { platform_name: @platform_name, location_name: @location })\
      .where(variables: { report_enabled: true })\
      .where("DATE(step_values.created_at) BETWEEN ? AND ?", @start_date, @end_date)\
      .group(:raw_value)\
      .count
  end

  def number_of_tracking_tickets
    statuses = Ticket.statuses
    status_values = statuses.fetch_values(:incomplete, :completed)

    Track
      .joins(:ticket, step: :message)\
      .where(messages: { platform_name: @platform_name, location_name: @location })\
      .where(tickets: { status: [status_values] })
      .where("DATE(tracks.created_at) BETWEEN ? AND ?", @start_date, @end_date)
      .group("tickets.status")
      .count
      .transform_keys { |k| statuses.key(k).capitalize }
  end

  def most_requested_service
    StepValue\
      .joins(step: :message, variable_value: :variable)\
      .where(messages: { platform_name: @platform_name, location_name: @location })\
      .where(variables: { is_most_request: true })\
      .where("DATE(step_values.created_at) BETWEEN ? AND ?", @start_date, @end_date)
      .order("count_all DESC")\
      .group("variable_values.raw_value")\
      .limit(1)\
      .count
  end

  def join_text_message
    Message\
      .joins("INNER JOIN text_messages ON text_messages.id=messages.content_id")\
      .where("messages.location_name=?", @location)
      .where("DATE(text_messages.created_at) BETWEEN ? and ?", @start_date, @end_date)
  end

  def join_voice_message
    Message\
      .joins("INNER JOIN voice_messages ON voice_messages.id=messages.content_id")
      .where("DATE(voice_messages.created_at) BETWEEN ? and ?", @start_date, @end_date)
  end

  def chartjs_colors
    @chartjs_colors ||= %w(#1cc88a #4e73df #f63e3e #7400b8 #bdb2ff #bc6c25 #5e6472 #ff5d8f #fee440 #1a936f)
  end
end
