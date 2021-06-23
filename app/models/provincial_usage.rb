class ProvincialUsage
  def initialize(options, pro_code)
    @options = options
    @pro_code = pro_code
  end

  def province_name
    Pumi::Province.find_by_id(@pro_code).send("name_#{I18n.locale}".to_sym)
  end

  def visits_count
    visits[@pro_code]
  end

  def unique_users_count
    uniques[@pro_code]
  end

  def service_delivered_count
    service_delivered[@pro_code]
  end

  def most_request_service
    most_request_services[@pro_code]
  end
  
  private

  def visits
    @visits ||= Session.filter(@options)\
                      .unscope(:order)\
                      .group(:province_id)\
                      .count
  end

  def uniques
    @uniques ||= Session.select("*")\
          .from("(#{
            Session
              .filter(@options)\
              .select('DISTINCT ON (province_id, session_id) *')\
              .reorder(:province_id, :session_id, :gender)
              .to_sql
          }) subquery")\
          .unscope(:order)\
          .group(:province_id)\
          .count
  end

  def service_delivered
    @service_delivered ||= StepValue.filter(delivered_options, delivered_scope)\
                            .group(:province_id)\
                            .count
  end

  def delivered_options
    @delivered_options ||= @options.merge({ variable_id: Variable.user_visit&.id })
  end

  def delivered_scope
    @delivered_scope ||= StepValue.joins(:session, variable_value: :variable)
  end

  LAST_ITEM_IN_ARRAY = -1
  def most_request_services
    most_request_service_query.each_with_object({}).each do |(key, count), cloned|
      pro_code, variable_value_id = key
      cloned[pro_code] = [variable_value_id, count, 0] unless cloned[pro_code]
      cloned[pro_code][LAST_ITEM_IN_ARRAY] += count
    end
  end

  def most_request_service_query
    @most_request_service_query ||= StepValue.filter(@options.merge(most_request_service_options))\
              .joins(:session)\
              .group(:province_id, :variable_value_id)\
              .order(:province_id, count_all: :desc)\
              .count
  end

  def most_request_service_options
    { variable_id: Variable.most_request&.id }
  end
end
