class DashboardQuery
  attr_reader :options

  def initialize(options = {})
    @options = options
    platform = platform_param[@options[:platform].try(:to_sym)]
    @options[:platform_name] = ["Messenger", "Telegram", "Verboice"]
    @options.merge!(platform) if platform.present?
  end

  def most_requested_services
    most_request = Variable.most_request

    return {} unless most_request.present?

    result = ::MostRequest.new(most_request).result
    result.transform
  end

  def gender_info
    result = ::GenderInfo.new(nil, self).result

    result.transform
  end

  def access_info
    result = ::AccessInfo.new(nil, self).result

    result.transform
  end

  def access_main_service
    main_service = Variable.service_accessed
    result = ::AccessMainService.new(main_service, self).result

    result.transform
  end

  def most_request_periodic
    most_request = Variable.most_request
    result = ::MostRequestPeriodic.new(most_request).result
    result.transform
  end

  def information_access_by_period
    { "Jan" => 200, "Feb" => 300, "Mar" => 400, "Apr" => 140, "May" => 300 }
  end

  def number_access_by_main_services
    { "Jan" => 200, "Feb" => 300, "Mar" => 400, "Apr" => 140, "May" => 300 }
  end

  def most_service_tracked_by_periodic
    { "Jan" => 200, "Feb" => 300, "Mar" => 400, "Apr" => 140, "May" => 300 }
  end

  def ticket_tracking_by_gender
    { "Femal" => 200, "Male" => 300, "Other" => 400 }
  end

  def overall_rating_by_owso
    [
      { name: "like", data: {"kamrieng": 12, "bavel": 95, "tmorkol": 65, "battambong": 59 }},
      { name: "acceptable", data: {"kamrieng": 56, "bavel": 42, "tmorkol": 65, "battambong": 80 }},
      { name: "dislike", data: {"kamrieng": 85, "bavel": 74, "tmorkol": 36, "battambong": 73 }},
    ]
  end

  def owso_feedback_trend
    [
      {name: "like", data: {"Jan": 12, "Feb": 95, "Mar": 65, "Apr": 59}},
      {name: "acceptable", data: {"Jan": 56, "Feb": 42, "Mar": 65, "Apr": 80}},
      {name: "dislike", data: {"Jan": 85, "Feb": 74, "Mar": 36, "Apr": 73}},
    ]
  end

  def feedback_by_sub_category
    [
      {name: "staff", data: {"like": 65, "dislike": 57}},
      {name: "price", data: {"like": 85, "dislike": 74}},
      {name: "working hour", data: {"like": 15, "dislike": 85}},
      {name: "document", data: {"like": 42, "dislike": 34}},
      {name: "process", data: {"like": 78, "dislike": 57}},
      {name: "delivery speed", data: {"like": 14, "dislike": 32}},
      {name: "providing info", data: {"like": 19, "dislike": 6}},
    ]
  end

  def user_count
    sessions.count
  end

  def user_unique_count
    user_unique.length
  end

  def user_unique
    return [] if user_count <= 0

    sessions.select("DISTINCT ON (session_id) *").unscope(:order)
  end

  def user_accessed_count
    total_users_visit_each_functions.values.sum
  end

  def unique_by_genders
    return if user_unique_count <= 0

    raw_sql = <<~SQL
      SELECT gender, COUNT(gender) AS gender_count FROM (
        #{ user_unique.to_sql }
      ) AS inner_query
      WHERE gender <> ''
      GROUP BY gender
      ORDER BY gender
    SQL

    Session.find_by_sql(raw_sql)
  end

  def sessions
    Session.filter(@options)
  end

  def total_users_visit_by_category
    user_visit_report = ::UserVisitEachFunction.new(nil, self)
    user_visit_report.chart_options
  end

  def total_users_visit_each_functions
    variable = Variable.user_visit

    return {}  if variable.nil?
    
    result = StepValue.total_users_visit(variable, @options)

    return {} if result.blank?

    default_chartjs_color_mapping.merge(result).transform_keys(&:humanize)
  end

  def users_by_genders
    users_gender_report = ::UserByGender.new(nil, self)
    users_gender_report.chart_options
  end

  def users_visited_by_each_genders
    result = StepValue.users_visited_by_each_genders(@options)
    result = result.group(:gender).count

    return {} if Variable.gender.nil?

    result.each_with_object({}).with_index do |((raw_gender, count), gender), index|
      mapping_gender = mapping_variable_value[raw_gender]&.mapping_value
      gender[mapping_gender] = count
    end
  end

  def mapping_variable_value
    Variable.gender.values.inject({}) do |hash, variable_value|
      hash[variable_value.raw_value] = variable_value
      hash[variable_value.mapping_value_en] = variable_value
      hash[variable_value.mapping_value_km] = variable_value
      hash
    end
  end

  # prevent inconsistent chartjs color
  def default_chartjs_color_mapping
    return {} unless user_visit.present?

    default = {}
    key = "mapping_value_#{ I18n.locale }".to_sym
    user_visit.values.each { |val| default[val.send(key)] = 0 }
    default
  end

  def ticket_tracking
    ticket_tracking_report = ::TicketTracking.new(nil, self)
    ticket_tracking_report.chart_options
  end

  def number_of_tracking_tickets
    result = Tracking.filter(@options).group(:status).count

    result.transform_keys { |k| I18n.t(k.downcase.to_sym) }
  end

  def total_users_feedback
    variable = Variable.feedback

    return [] if variable.nil?

    StepValue.total_users_feedback(variable, @options)
  end

  def users_feedback
    users_feedback_report = ::UserFeedback.new(nil, self)
    users_feedback_report.chart_options
  end

  def total_users_feedback_by_gender
    report = ::UserFeedbackGender.new(nil, self)
    report.chart_options
  end

  def most_requested_service
    most_request_variable = Variable.most_request
    return unless most_request_variable.present?

    top_hit = most_request_variable.agg_value_count(@options).first
    most_request_variable.transform_key_result(*top_hit) if top_hit.present?
  end

  def total_requested_service
    Variable.most_request.agg_value_count(@options).values.sum
  end

  def goals
    @goals ||= [accessed, submitted].compact
  end

  def user_visit
    @user_visit ||= Variable.user_visit
  end

  def feedback
    @feedback ||= Variable.feedback
  end

  private
    def platform_param
      {
        ivr: { platform_name: ["Verboice"], content_type: 'VoiceMessage' },
        chatbot: { platform_name: ["Messenger", "Telegram"], content_type: 'TextMessage' }
      }
    end

    def accessed
      accessed = Session.unscope(:order).accessed(@options)

      return {} unless accessed
      data = accessed.group_by_day(:created_at, format: "%b %e").count

      { name: I18n.t("dashboard.accessed"), data: data, color: "#ffbc00", title: I18n.t("dashboard.accessed_explain"), class_name: "rect__accessed", display_text: I18n.t("dashboard.accessed") } if data.present?
    end

    # Ticket does not need to care about about platform(both, chatbot, ivr)
    # because it syncs from desktop app).
    def submitted
      data = Ticket.filter(@options).group_by_day(:requested_date, format: "%b %e").count

      { name: I18n.t("dashboard.submitted"), data: data, color: '#4e73df', title: I18n.t("dashboard.submitted_explain"), class_name: "rect__submitted", display_text: I18n.t("dashboard.submitted") } if data.present?
    end
end
