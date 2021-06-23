# query options (filter)
# province filter
class ProvincialUsage
  attr_reader :pro_name, :unique_user, :visit, :service_delivered

  def initialize(pro_name:, unique_user:, visit:, service_delivered:)
    @pro_name = pro_name
    @unique_user = unique_user
    @visit = visit
    @service_delivered = service_delivered
  end

  def self.within(query)
    ProvinceFilter.fetch(query.province_codes).map do |pro_code|
      new(
        pro_name: Pumi::Province.find_by_id(pro_code).name_latin,
        unique_user: unique_users(query.options)[pro_code],
        visit: visit(query.options)[pro_code],
        service_delivered: service_delivered(query.options)[pro_code]
      )
    end
  end

  def self.unique_users(options)
    TotalUniqueUser.within(options)
  end

  def self.visit(options)
    TotalVisit.within(options)
  end

  def self.service_delivered(options)
    ServiceDelivered.within(options)
  end
end

class ServiceDelivered
  def self.within(options)
    StepValue.filter(options.merge(variable_options), scope)\
              .group(:province_id)\
              .count
  end
  
  private

  def self.variable_options
    { variable_id: Variable.user_visit&.id }
  end

  def self.scope
    StepValue.joins(:session, variable_value: :variable)
  end
end

class TotalUniqueUser
  def self.within(options)
    sql = Session.select("*")\
            .from("(#{distinct_within(options).to_sql}) subquery_sessions")\
            .unscope(:order)\
            .group(:province_id)\
            .count
  end

  private

  def self.distinct_within(options)
    sql = Session.filter(options)\
            .select("DISTINCT ON (province_id, session_id) *")\
            .reorder(:province_id, :session_id, :gender)
  end
end

# start_date: "2020/08/28", end_date: "2021/06/21"
class TotalVisit
  def self.within(options)
    Session\
      .filter(options)\
      .unscope(:order)\
      .group(:province_id)\
      .count
  end
end
