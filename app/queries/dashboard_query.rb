class DashboardQuery
  include Chart::ReportHelper
  attr_reader :options

  def initialize(options = {})
    @options = options
    platform = platform_param[@options[:platform].try(:to_sym)]
    @options[:platform_name] = ["Messenger", "Telegram", "Verboice"]
    @options.merge!(platform) if platform.present?
  end

  def user_count
    sessions.count
  end

  def user_unique_count
    user_unique.length
  end

  def user_unique
    return [] if user_count <= 0

    sessions.select("DISTINCT ON (session_id) *").reorder(:session_id, :gender)
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
    @goals ||= [accessed, submitted_ticket_in_kamrieng, submitted_ticket_in_poipet].compact
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
    Array.wrap(province_codes) - ["00"]
  end

  def district_codes
    options[:district_id].presence || all_district_codes
  end

  def district_codes_without_other
    district_codes - ["0000"]
  end

  private

    def all_province_codes
      Filters::PumiFilter.pilot_province_codes
    end

    def all_district_codes
      Filters::PumiFilter.pilot_district_codes
    end

    def platform_param
      {
        ivr: { platform_name: ["Verboice"], content_type: 'VoiceMessage' },
        chatbot: { platform_name: ["Messenger", "Telegram"], content_type: 'TextMessage' }
      }
    end

    # TODO: move site code to setting
    # mark_as: service_accessed( variable = owso_info )
    def accessed
      accessed = Session.unscope(:order).accessed(@options)

      return {} unless accessed
      data = accessed.group_by_day(:created_at, format: "%b %e, %y").count

      { name: I18n.t("dashboard.accessed"), data: data, color: "#ffbc00", title: I18n.t("dashboard.accessed_explain"), class_name: "rect__accessed", display_text: I18n.t("dashboard.accessed") } if data.present?
    end

    # Ticket does not need to care about about platform(both, chatbot, ivr)
    # because it syncs from desktop app).
    def submitted_ticket_in_kamrieng
      # .for_location("0212")
      data = Ticket.filter(@options).group_by_day(:requested_date, format: "%b %e, %y").count

      { name: I18n.t("dashboard.submitted", site_name: I18n.t("sites.kamrieng")), data: data, color: '#4e73df', title: I18n.t("dashboard.submitted_explain", site_name: I18n.t("sites.kamrieng")), class_name: "rect__submitted", display_text: I18n.t("dashboard.submitted", site_name: I18n.t("sites.kamrieng")) } if data.present?
    end

    def submitted_ticket_in_poipet
      data = Ticket.filter(@options).for_location("0110").group_by_day(:requested_date, format: "%b %e, %y").count

      { name: I18n.t("dashboard.submitted", site_name: I18n.t("sites.poipet")), data: data, color: '#673AB7', title: I18n.t("dashboard.submitted_explain", site_name: I18n.t("sites.poipet")), class_name: "rect__submitted", display_text: I18n.t("dashboard.submitted", site_name: I18n.t("sites.poipet")) } if data.present?
    end
end
