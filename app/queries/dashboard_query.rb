class DashboardQuery
  include Chart::ReportHelper
  attr_reader :options

  def initialize(options = {})
    @options = options
    platform = platform_param[@options[:platform].try(:to_sym)]
    @options[:platform_name] = ["Messenger", "Telegram", "Verboice"]
    @options.merge!(platform) if platform.present?
  end

  def most_requested_services
    # { colors: ,label: ,peak: , data: [{ district1: { value:, :count } }, {...}] }

    return {} unless Variable.most_request

    most_requested_report = ::MostRequest.new(most_request, self)
    most_requested_report.chart_options
  end

  def gender_info
    ::GenderInfo.new(nil, self).chart_options
  end

  def access_info
    ::AccessInfo.new(nil, self).chart_options
  end

  def access_main_service
    main_service = Variable.service_accessed
    ::AccessMainService.new(main_service, self).chart_options
  rescue
    {}
  end

  def most_tracked_periodic
    ::MostTrackedPeriodic.new(nil, self).chart_options
  end

  def ticket_tracking_by_genders
    ::TicketTrackingByGenders.new(nil, self).chart_options
  end

  def overall_rating
    feedback = Variable.feedback
    result = ::OverallRating.new(feedback, self).result
    result.transform
  end

  def feedback_trend
    feedback = Variable.feedback
    ::FeedbackTrend.new(feedback, self).chart_options
  rescue
    {}
  end

  def feedback_sub_categories
    categories_all.merge(categories_separate)
  end

  def information_access_by_period
    { "Jan" => 200, "Feb" => 300, "Mar" => 400, "Apr" => 140, "May" => 300 }
  end

  def number_access_by_main_services
    { "Jan" => 200, "Feb" => 300, "Mar" => 400, "Apr" => 140, "May" => 300 }
  end

    data = result.each_with_object({}) do |(k, v), h|
      district_id, variable_value_id = k
      district = Pumi::District.find_by_id(district_id)
      value = VariableValue.find(variable_value_id)

      h[district.name_en] = { value: value.mapping_value.sub(/\s/, "\n"), count: v } if !h[district.name_en] || (h[district.name_en] && h[district.name_en][:count] < v)
    end

    output[:data] = data
    output
  end

  def information_access_by_period
    { "Jan" => 200, "Feb" => 300, "Mar" => 400, "Apr" => 140, "May" => 300 }
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

  def total_users_visit_each_functions
    variable = Variable.user_visit

    return {}  if variable.nil?
    
    result = StepValue.total_users_visit(variable, @options)

    return {} if result.blank?

    default_chartjs_color_mapping.merge(result).transform_keys(&:humanize)
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

  def province_codes
    options[:province_id].presence || all_province_codes
  end

  def province_codes_without_other
    province_codes - ["00", "nu"]
  end

  def district_codes
    options[:district_id].presence || all_district_codes
  end

  def district_codes_without_other
    district_codes - ["0000"]
  end

  private
    def all_province_codes
      Session.pluck(:province_id).compact.uniq
    end
    
    def categories_all
      result = ::FeedbackSubCategories.new(nil, self).result
      result.transform
    end

    def categories_separate
      result = ::FeedbackSubCategoryItem.new(nil, self).result
      result.transform
    end

    def all_district_codes
      location = Variable.location
      return [] unless location

      location.values.map(&:raw_value)
    end

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
